From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 14 Feb 2014 21:36:29 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <20140214074407.GA2569@katana>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana> <20140213225248.GB15350@lukather>
 <20140214074407.GA2569@katana>
Message-ID: <20140214203629.GE15350@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 08:44:07AM +0100, Wolfram Sang wrote:
> 
> > > For non-a10, That should be at least
> > > 
> > > 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
> > > 
> > > or
> > > 
> > > 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
> > > 
> > > depending on the outcome above.
> > > 
> > > Or is my knowledge outdated already?
> > > 
> > 
> > Since they are strictly compatible, we don't need to introduce any
> > different compatible string here.
> 
> You never know all errata in advance. From what I know, one should
> always use the specfic naming first, and then the generic fallback. So,
> in case a distinction is needed later (think errata), then one doesn't
> need to change the devicetrees.
> 

And adding a A13-specific compatible wouldn't change anything, because
it does work on at least one revision of them, so if you'd have to
deal with an errata, you'd have to introduce a new compatible for this
revision only anyway.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/357283a9/attachment.sig>
