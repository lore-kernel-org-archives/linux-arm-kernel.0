From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Jul 2017 18:33:08 +0200
Subject: "external abort on linefetch (0x814)" on Kirkwood 6282 SoC
In-Reply-To: <1501085885.3330.24.camel@hellion.org.uk>
References: <1500801941.22097.24.camel@hellion.org.uk>
 <20170726152251.GE12049@lunn.ch>
 <1501085885.3330.24.camel@hellion.org.uk>
Message-ID: <20170728163308.GJ2132@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hello kirkwood folks,
> 
> We have been seeing reports on the Debian arm list about
> instability/errors running Debian Stretch (4.9 based) on
> various?Kirkwood 6282 based QNAP systems. Errors are things like [0,
> actually one of the earlier pre-4.9 reports, same symptoms as with 4.9
> though]:
> 
> [???37.167103] BUG: Bad rss-counter state mm:c0caa1e0 idx:1 val:1
> [??783.570365] BUG: Bad rss-counter state mm:c09e6220 idx:1 val:1
> [??800.172223] BUG: Bad rss-counter state mm:ecbc05e0 idx:1 val:1
> [??829.005336] BUG: Bad rss-counter state mm:c0d4b880 idx:1 val:1
> [??871.773956] BUG: Bad rss-counter state mm:c09e63c0 idx:1 val:1
> [ 1299.565344] BUG: Bad rss-counter state mm:ecaf8c40 idx:1 val:1
> 
> and
> 
> [???71.033784] Unhandled fault: external abort on linefetch (0x014) at
> 0xb6c73db0
> [???71.041037] pgd = ead9c000
> [???71.043747] [b6c73db0] *pgd=3fd72831
> [???84.144056] Unhandled fault: external abort on linefetch (0x014) at
> 0xb6d44db0
> [...]

So far, i've not been able to reproduce this. I have 6282 based QNAP
NAS box, with a single disk. Since this is a kernel hacking box, i
tftpboot and don't use an initrd. I've been using the
mvebu_v5_defconfig kernel configuration and i have tried v4.13-rc2,
v4.12, v4.10.0 and v3.9.30. And i have sid for user space.

       Andrew
