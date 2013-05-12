From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 12 May 2013 12:05:04 -0700
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <20130512143344.GC3200@sirena.org.uk>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <20130510212422.GY3200@sirena.org.uk>
 <7e18bed3-ae6b-4aa0-bf23-b6c61ba8b85b@CO9EHSMHS030.ehs.local>
 <20130512143344.GC3200@sirena.org.uk>
Message-ID: <9e55c552-ce34-4663-9a57-bf2c626d7d58@TX2EHSMHS008.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 06:33:44PM +0400, Mark Brown wrote:
> On Sat, May 11, 2013 at 09:54:22AM -0700, S?ren Brinkmann wrote:
> > On Fri, May 10, 2013 at 10:24:22PM +0100, Mark Brown wrote:
> 
> > > For your use case should these things be exposed by the FPGA device
> > > asking for that rather than by having the clocks available separately?
> > > Or is this part of the DT blob that's loaded incrementally along with
> > > the FPGA (which does make things more interesting of course...).
> 
> > Here may be some misunderstanding.
> > The clocks are not in the FPGA. The clocks are always there and part of
> > the processing system (PS), they are just routed to the FPGA where they
> > can be used as clocks for the FPGA design.
> 
> No, there's no confusion here - the clocks that are being exposed to
> userspace are the clocks which enter the FPGA.  The driver or whatever
> that understands the FPGA can do what is needed to control them,
> including routing them on to subdevices it instantiates or exposing them
> to userspace.
Such a driver does not exist in general.
For some IP cores, Linux drivers do exist and then
they are supposed to directly use the CCF, IMHO, no need to expose
things to userspace in that case.
I'm trying to cover cases, in which there is no driver available/needed for
the FPGA design, other than some simple clock controls.

As simple example, if you wrote your own HW blinken lights design, you
wouldn't have nor need a Linux driver for it, but if you used these
clocks as inputs you could change the blinking speed by adjusting the
frequency.

	S?ren
