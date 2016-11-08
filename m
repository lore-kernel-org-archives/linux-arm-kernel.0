From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 19:45:12 +0100
Subject: [PATCH 1/2] clk: sunxi-ng: Fix CPUX clock for the A23/A33
In-Reply-To: <20161107173135.Ux5KXCv5@smtp1h.mail.yandex.net>
References: <20161107173135.Ux5KXCv5@smtp1h.mail.yandex.net>
Message-ID: <20161108184512.jlln3xyvege6jcnb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 05:36:03PM +0800, Icenowy Zheng wrote:
> > And your commit log should explain why it is an issue. Yours is even 
> > wrong here, we could definitely change the rate of these clocks 
> > already. The only thing that was not allowed was to change the rate of 
> > its parents, which is what this patch fixes. 
> >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> > > --- 
> > > Patch 4.9-rc too. 
> >
> > I don't see why it should be part of 4.9. No one uses that code in 4.9. 
> 
> It can be triggered by a modified dt in 4.9, by add operating points.

Still, there's no reason to fix something that is not used by anyone,
it can definitely wait until the next release. Linus also said that he
didn't want patches like that last week.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/fed056dc/attachment.sig>
