From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 13 Nov 2014 13:31:43 +0200
Subject: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
In-Reply-To: <20141112150210.GC26481@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com> <20141112150210.GC26481@atomide.com>
Message-ID: <5464969F.30708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/14 17:02, Tony Lindgren wrote:

>> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
>> places in the kernel. I wonder if adding a pinmux entry for it could
>> cause some rather odd problems.
> 
> They can all use pinctrl-single no problem.

Can, but don't. That's my worry. If we touch the DEVCONF1 via pinmux,
and we have code in mach-omap2 that also touch DEVCONF1, without any
knowledge (and locking) between those...

So _maybe_ that's not an issue, as the pinmux config we have here is
fixed, and done once at boot time, and maybe the code in mach-omap2 that
touch DEVCONF1 is also ran just once and not at the same time as the
pinmux. But I don't know if that's so.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/a9b3d896/attachment.sig>
