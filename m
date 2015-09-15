From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 15 Sep 2015 12:37:22 +0100
Subject: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
In-Reply-To: <20150915110330.GA6507@leverpostej>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
 <1442251092.2850.53.camel@linaro.org>
 <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
 <1442313962.2917.25.camel@linaro.org> <20150915110330.GA6507@leverpostej>
Message-ID: <1442317042.2917.29.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-15 at 12:03 +0100, Mark Rutland wrote:
> On Tue, Sep 15, 2015 at 11:46:02AM +0100, Jon Medhurst (Tixy) wrote:
> > On Tue, 2015-09-15 at 10:37 +0100, Punit Agrawal wrote:
> > > "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> > > 
> > > > On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> > > >> Mark Rutland <mark.rutland@arm.com> writes:
> > > >> 
> > [...]
> > > >> The way the SCP interface is defined, the sensor identifiers are
> > > >> contiguous,
> > > >
> > > > Is there any documentation other than DUI0922A? [1] From what I can seen
> > > > that just says it's a 16-bit value and doesn't put any particular
> > > > constraints on its value.
> > > 
> > > Although not explicitly stated, if you look at the Get Sensor Capability
> > > [2] and Get Sensor Info [3] commands you can indirectly infer that the
> > > Sensor IDs are contiguous.
> > 
> > I personally wouldn't even indirectly infer they are contiguous from
> > what the document says. If I were implementing the firmware I would feel
> > quite in my rights to, for example, use the top 8 bits of the ID for a
> > sensor type and the bottom 8 for an index, if that made dispatching of
> > requests more efficient. Or if some optional hardware was detected as
> > missing, leaving some holes in ID space.
> > 
> > As a specification of a 'standard' the document seems to be rather
> > lacking. So, Sensor ID should be documented as being "an unsigned
> > integer less than then number of sensors returned by the Get Sensor
> > Capability command", or something like that. I guess clocks and other
> > devices suffer from similar lack of specificity.
> 
> I think from the PoV of the binding, this doesn't matter. The value is
> just an arbitrary opaue token written down in a spec, that the FW
> understands how to interpret.

True, it's the Linux implementation in following patches that has
assumptions, e.g. for loops iterating over id's 0..N-1
 
> 
> I only asked about how the IDs were organised because I thought there
> was additional translation in the kernel, but this is not the case.
> 
> The only potential problem is bit-width. Punit, I assume the value is
> 32-bit (or less) in the messages to the FW?

It's 16 bit.

-- 
Tixy
