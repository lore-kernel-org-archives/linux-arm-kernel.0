From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 19 Nov 2015 16:04:03 +0000
Subject: [PATCH] ARM: xip: Move XIP linking to a separate file
In-Reply-To: <alpine.LFD.2.20.1511191050080.22569@knanqh.ubzr>
References: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511191050080.22569@knanqh.ubzr>
Message-ID: <HK2PR06MB0561F1A746E04D0A205B2DBB8A1B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Nov 2015, Michal Marek wrote:
> Why not have a vmlinux.lds.S and #include a vmlinux-xip.lds.S / 
> vmlinux-nonxip.lds.S from there? That way, you do not clutter the
> main Makefile and you can reuse the boilerplate of the linker script.
> 
> Michal

On Thu, 19 Nov 2015, Nicolas Pitre wrote:
> I agree with Michal's suggestion to do the selection locally with an
> include.


That's actually how I started out locally, but I thought if I tried submitting that, I'd get a bunch of "Eww, that's ugly".
I'm happy to redo the patch and contain the dysfunctionalism of XIP to the ARM tree.

Chris
