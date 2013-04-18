From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Apr 2013 13:37:32 +0200
Subject: [PATCH 24/32] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <20130418113138.GD27903@gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <201304181306.34835.arnd@arndb.de> <20130418113138.GD27903@gmail.com>
Message-ID: <201304181337.32700.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 April 2013, Lee Jones wrote:
> You're right, I am a little confused by them.
> 
> I call them 'device type' because that's what they're called already.
> Grep for 'dma_dev_type'. This is the number which gets split into
> event group and line, like this:
> 
>         event_group = D40_TYPE_TO_GROUP(dev_type);
>         event_line = D40_TYPE_TO_EVENT(dev_type);
> 
> > and I would put that number first.
> 
> So you want me to switch that round so it looks like:
> 
>         dmas = <<phandle> <dev_type> <fixed_chan> <flags>;
> 
> Instead of what I have at the moment:
> 
>         dmas = <<phandle> <fixed_chan> <dev_type> <flags>;
> 
> Correct?

Yes, that's probably better and more in line with what the other
drivers do. You could also put the fixed_chan last if that helps.

I would still like to get a confirmation that we actually still
require the fixed channel assignment, since it's just used
in one driver, and that might only be needed for some buggy
hardware revision if we're lucky.

	Arnd
