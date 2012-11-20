From: rric@kernel.org (Robert Richter)
Date: Tue, 20 Nov 2012 18:06:01 +0100
Subject: [PATCH 1/1] ARM: oprofile: add A5/A7/A15 entries in op_perf_name
In-Reply-To: <20121120165517.GC27765@mudshark.cambridge.arm.com>
References: <1351853016-4476-1-git-send-email-jgq516@gmail.com>
 <20121105113102.GF3351@mudshark.cambridge.arm.com>
 <20121120121747.GJ2504@rric.localhost>
 <20121120155717.GD26475@mudshark.cambridge.arm.com>
 <20121120163158.GO2504@rric.localhost>
 <20121120165517.GC27765@mudshark.cambridge.arm.com>
Message-ID: <20121120170601.GR2504@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.12 16:55:17, Will Deacon wrote:
> On Tue, Nov 20, 2012 at 04:31:58PM +0000, Robert Richter wrote:
> > I am thinking of the following:
> > 
> >  # cat /root/cpu_type
> >  arm/armv7-ca5
> >  # cat /dev/oprofile/cpu_type
> >  unknown
> >  # mount --bind /root/cpu_type /dev/oprofile/cpu_type
> >  # cat /dev/oprofile/cpu_type
> >  arm/armv7-ca5
> > 
> > From here legacy oprofile tools work as expected using oprofilefs. (I
> > think. Did not test it.) We need to change the kernel for this a bit
> > to return 'unknown'. The mount could be done by the oprofile tools
> > using existing cpu detection code. This is only one way to setup
> > cpu_type from userland, there could be other ways too.
> 
> Ok, this is functionally equivalent to the patch that was submitted at the
> start of this thread: it solves the problem of mapping a single ARM core to
> a oprofile's CPU ID string. Technically, I don't mind doing that in the
> kernel (at least, it means you don't need to do your trick above)

The advantage of a solution where userland updates cpu_type is that we
never need to update the kernel anymore. This means, cpu detection can
be part of the tools.

-Robert
