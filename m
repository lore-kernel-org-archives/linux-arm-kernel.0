From: marex@denx.de (Marek Vasut)
Date: Fri, 3 Aug 2012 21:08:06 +0200
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
In-Reply-To: <20120803190640.GF10335@n2100.arm.linux.org.uk>
References: <1344009354-13249-1-git-send-email-marex@denx.de>
 <201208032046.28211.marex@denx.de>
 <20120803190640.GF10335@n2100.arm.linux.org.uk>
Message-ID: <201208032108.06819.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

> On Fri, Aug 03, 2012 at 08:46:27PM +0200, Marek Vasut wrote:
> > Dear Russell King - ARM Linux,
> > 
> > [...]
> > 
> > > > > No need to set it to 32768.
> > > > > 
> > > > > If you just remove the 'CONFIG_DEFAULT_MMAP_MIN_ADDR=65536' then
> > > > > this symbol will be 32768.
> > > > 
> > > > Sorry, ignore what I said. I just realized that the default is 4096.
> > > 
> > > 4096 is also fine for ARM too.  There's not much point in having
> > > defconfigs change it - that would just be pure noise in the config
> > > files.
> > 
> > Wasn't there a security concern being the reason for setting this higher?
> 
> I don't believe there is.  The only requirement is that the first page
> on older CPUs isn't stomped on (and we preserve that for later CPUs so
> that NULL pointer derefs get caught.)
> 
> The higher it is the better though, because it means NULL pointer + offset
> deref with larger offsets also gets caught.

Understood!

> > Also,
> > I still don't completely understand why ARM has to set it lower than
> > others, is that an ABI thing?
> 
> Yes, we have always loaded user programs at 0x8000 by default, which are
> generally not relocatable.  So if you set it to 64K, you prevent non-root
> user programs being mapped in, which is why stuff gets killed as soon as
> UID != 0.

I see! Thanks for explaining!

Best regards,
Marek Vasut
