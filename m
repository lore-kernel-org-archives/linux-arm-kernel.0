From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 30 Aug 2017 08:45:37 +0200
Subject: Possible regression between 4.9 and 4.13
In-Reply-To: <20170830063623.GA16076@wunner.de>
References: <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
 <20170829133852.GA13355@wunner.de>
 <20170829144725.GB22532@kroah.com>
 <20170829153456.GA13712@wunner.de>
 <20170829155138.GA32369@kroah.com>
 <20170830063623.GA16076@wunner.de>
Message-ID: <20170830064537.GA8856@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 08:36:23AM +0200, Lukas Wunner wrote:
> On Tue, Aug 29, 2017 at 05:51:38PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 29, 2017 at 05:34:56PM +0200, Lukas Wunner wrote:
> > > On Tue, Aug 29, 2017 at 04:47:25PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Aug 29, 2017 at 03:38:52PM +0200, Lukas Wunner wrote:
> > > Is 0xffffffff not a valid value to be stored in and read from mmio space?
> > 
> > For a specific register, doubtful
> 
> Well, "doubtful" means you don't know for sure.
> 
> It's fine to check for "all ones" as a heuristic if that's not a valid
> value for the register read, however a hotplug notification is a
> *definitive* indication the hardware is gone.
> 
> I you seem to prefer forgoing a *definitive* indication for a mere
> heuristic, that doesn't make sense from my point of view.

I still don't know what you are arguing about here.  The _driver_ knows
if a specific read allows all ones as a valid return value.  If it
isn't, then the driver knows the device is now gone.  It's that simple,
don't do that type of check if all ones is a valid read.

And that's not what is happening here anyway, so again, what is this
discussion about?

Unless there's something specific we can do here for the xhci driver, I
think this thread is dead until someone determines what is going wrong
with the hardware the original reporter posted about.

greg k-h
