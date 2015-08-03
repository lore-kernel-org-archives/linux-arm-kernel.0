From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:13:00 +0200
Subject: [PATCH] ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20
 to a level all boards can supply
In-Reply-To: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
References: <1438543386-7253-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <20150803091300.GY2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 09:23:06PM +0200, Timo Sigurdsson wrote:
> sun7i-a20.dtsi contains an cpufreq operating point at 0.9 volts. Most A20 boards
> (or all?), however, do not allow the voltage to go below 1.0V. Thus, raise the
> voltage for the lowest operating point to 1.0V so all boards can actually use
> it.

This is not a property of a board, but is the actual limit documented
by Allwinner for the A20. Some individual SoCs might have wider
tolerances, but that's not a property of a board, it's really a
property of a single SoC, and we cannot make any assumption on the
board.

(and please make sure to run checkpatch before sending your patches)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/50e7d12a/attachment.sig>
