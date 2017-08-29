From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Aug 2017 17:48:24 +0100
Subject: [PATCH] drm: hdlcd: allow HDLCD to be used without interrupt
In-Reply-To: <20170829133351.GK10796@e110455-lin.cambridge.arm.com>
References: <E1daJCF-0003pG-DI@rmk-PC.armlinux.org.uk>
 <20170726102748.GM31807@n2100.armlinux.org.uk>
 <20170728152311.GA970@e110455-lin.cambridge.arm.com>
 <20170728155827.GV31807@n2100.armlinux.org.uk>
 <20170829133351.GK10796@e110455-lin.cambridge.arm.com>
Message-ID: <20170829164824.GH20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 02:33:52PM +0100, Liviu Dudau wrote:
> I've worked with Vladimir Murzin inside ARM to try to sort out problems
> on the board like the one that you have. He's got to a point where the HDLCD
> starts correctly after adding a non-fixed pxlclk source, but then the rest of
> the setup is semi-useless without a working IRQ because DRM atomic calls
> will give you a vblank timeout splat everytime you invoke them. So I'm
> not sure how you want to progress with this patch, as not having an IRQ
> line means you will not get any vblank interrupts and you can't use the
> driver with userspace that calls DRM API.
> 
> The RTL guys are apparently working on a fix, but I have no ETA or
> details on when they are going to do.

It sounds then like this patch doesn't make sense - so I'm happy
for it to be dropped.  It's something to bear in mind in the future
when folk decide whether to adopt fbdev or DRM support for hardware
that gets used in MMU-less hardware...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
