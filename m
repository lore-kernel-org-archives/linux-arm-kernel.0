From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 18 Oct 2011 15:15:20 +0100
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <201110181605.12512.arnd@arndb.de>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<20111017161854.GB5108@suse.de> <4E9D5FAB.2080605@linaro.org>
	<201110181605.12512.arnd@arndb.de>
Message-ID: <20111018141520.GA10054@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 18, 2011 at 04:05:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 October 2011, Lee Jones wrote:
> > On 17/10/11 17:18, Greg KH wrote:
> > > On Mon, Oct 17, 2011 at 12:52:54PM +0100, Lee Jones wrote:
> > >> +
> > >> +	bus_unregister(&soc_bus_type);
> > > 
> > > What happens if you have more than one SOC device?  I think you just
> > > oopsed.
> > 
> > I think you're right.
> > 
> > When to you suggest we unregister the bus?
> 
> Do it in the same way as registering it, as a module_exit() function
> below the initcall that instantiates it. These interfaces usually come
> in pairs, so if something does not look symmetric, you should better
> have another look.

I can't think of a system where it make sense to have this as a loadable 
module so can't we just register the bus_type and never unregister it 
like the platform and spi busses for example?

Also, (and I'm right at the edge of my knowledge here!) wouldn't you 
also need to add reference counting of the module when 
creating/destroying a soc device to prevent the module and bus 
disappearing whilst you had devices with a reference to it?

Jamie
