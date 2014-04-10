From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 10:16:11 +0200
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <CAGb2v651R-sG3OB4aD4UXWiyQVcHz7zXub1wO6B4xp-toUcC7Q@mail.gmail.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
 <534571F0.10706@free-electrons.com>
 <CAGb2v651R-sG3OB4aD4UXWiyQVcHz7zXub1wO6B4xp-toUcC7Q@mail.gmail.com>
Message-ID: <20140410081611.GN28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 01:14:26AM +0800, Chen-Yu Tsai wrote:
> >  3) other things I haven't noticed yet :-)
> 
> Reworking EINT to use one interrupt per bank will yield some more surprises.
> 
> There's also new gpiolib irqchip helpers, but that will require reworking
> each pin bank into separate gpio chips. May be more work than just adding
> different irq domains for different banks.
> 
> See: https://lkml.org/lkml/2014/3/25/175

I'm not sure it's worth it actually. Using these helpers will probably
simplify the A31/A23 case, where you have one interrupt controller per
bank, but it will be much more complicated to handle the A10/A20 case
where you have a single interrupt controller for all the banks.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/095244f2/attachment.sig>
