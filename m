From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 21:38:16 +0100
Subject: [PATCH 1/2] clk: sunxi: delay protected clocks until arch initcall
In-Reply-To: <7334994.mKnQpNNMP2@diego>
References: <1453385439-10154-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1453385439-10154-2-git-send-email-emilio.lopez@collabora.co.uk>
 <20160127153722.GC4317@lukather> <7334994.mKnQpNNMP2@diego>
Message-ID: <20160127203816.GU4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 27, 2016 at 05:14:17PM +0100, Heiko St?bner wrote:
> Hi,
> 
> Am Mittwoch, 27. Januar 2016, 16:37:22 schrieb Maxime Ripard:
> > I thought the patches were simply dropped and the
> > rockchip people just took another approach.
> 
> nope still on track ... especially as it was Stephen's believe that orphans 
> shouldn't even be usable to general clock users :-).
> 
> I just remember that the proposed general solution was based on Mike's 
> upcoming generic critical clock handling (the handoff thingy), which would 
> move critical clock handling out of architecture-specific code, so I've been 
> prodding Mike mainly.
> 
> Another option might be to allow clock-controllers to handle orphans and only 
> deny orphan usage to outside clock users, maybe expanding on what I did with 
> the clock-conf part in patch2.

I'm not sure that would solve anything in our case. All our clocks
drivers are different ones, so I'm not sure how we could handle that.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/01f08228/attachment.sig>
