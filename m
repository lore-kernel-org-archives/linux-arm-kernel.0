From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 22:38:07 +0200
Subject: [PATCH 5/8] dmaengine: ste_dma40: Ensure src and dst registers
 are configured correctly
In-Reply-To: <20130409190916.GF25316@gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <201304092057.29684.arnd@arndb.de> <20130409190916.GF25316@gmail.com>
Message-ID: <201304092238.07286.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Lee Jones wrote:
> On Tue, 09 Apr 2013, Arnd Bergmann wrote:
> 
> > On Tuesday 09 April 2013, Lee Jones wrote:
> > > Confusingly d40_log_cfg() is used to set up the logical channel
> > > configuration registers, but d40_phy_cfg() is used to configure
> > > physical and logical registers, so it should be called in both
> > > cases. It is the function call's final attribute which determines
> > > whether it's a physical or logical channel, not whether the
> > > function is called or not.
> > 
> > So how did it ever work? Your description sounds like it was
> > broken all along, but I would assume that someone tested the code.
> 
> From what I can see, not.
> 
> My best guess is that the 'test' was to see if the configuration
> changed using the debug print at the end of the function. I don't see
> how else the configuration can be written to hardware.

Acked-by: Arnd Bergmann <arnd@arndb.de>
