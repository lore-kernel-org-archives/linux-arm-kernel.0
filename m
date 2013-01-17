From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jan 2013 10:55:45 +0000
Subject: CoreSight framework and drivers
In-Reply-To: <20130116001458.GB7013@pratikp-linux.qualcomm.com>
References: <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com>
 <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com>
 <50D3972E.4030607@ti.com>
 <20121221221828.GA2658@pratikp-linux.qualcomm.com>
 <20121223113239.GG16237@mudshark.cambridge.arm.com>
 <20130103180643.GA30277@pratikp-linux.qualcomm.com>
 <20130107115836.GB13542@mudshark.cambridge.arm.com>
 <20130116001458.GB7013@pratikp-linux.qualcomm.com>
Message-ID: <20130117105545.GB3699@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 12:14:59AM +0000, Pratik Patel wrote:
> On Mon, Jan 07, 2013 at 11:58:36AM +0000, Will Deacon wrote:
> > On Thu, Jan 03, 2013 at 06:06:43PM +0000, Pratik Patel wrote:
> > > Whats the advantage in using debugfs here?
> > 
> > The main things I like about debugfs are (a) it's a text-driven interface
> > and easy to script with and (b) it matches what we do for ftrace.
> > 
> > Furthermore, it means that subtle differences between devices can be hidden
> > in the driver and not require different vendor tools for parsing the trace
> > data.
> > 
> Sorry for the delay and maybe I am missing something but it seems
> we can take care of such protocol or parsing/decoding differences
> even with device nodes since that seems independent of the
> interface used - per device debugfs attributes or per device
> device nodes.

You seem to be arguing that the two interfaces are equivalent, in which case
I say that we should follow ftrace's lead and use debugfs for this...

...but I still maintain that debugfs is also far easier to work with from
userspace.

> CoreSight trace solution is typically a SoC wide solution and
> hence can get used by non-Linux processors or hardware. Using
> debugfs would imply compiling it and exposing all the debug
> knobs even if the use case was to use the CoreSight solution for
> something that didn't need all that.

Many debug features require debugfs to be compiled, so I don't buy that as a
show-stopping argument in favour of using dev nodes. I also think that exposing
all of the debug knobs is actually a good thing, given the low-level nature of
coresight devices (where we're offloading most of the knowledge to userspace
anyway).

Will
