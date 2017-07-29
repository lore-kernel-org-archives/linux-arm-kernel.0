From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 29 Jul 2017 17:50:31 +0200
Subject: "external abort on linefetch (0x814)" on Kirkwood 6282 SoC
In-Reply-To: <1500801941.22097.24.camel@hellion.org.uk>
References: <1500801941.22097.24.camel@hellion.org.uk>
Message-ID: <20170729155031.GB19012@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 10:25:41AM +0100, Ian Campbell wrote:
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
> [???71.033784] Unhandled fault: external abort on linefetch (0x014) at 0xb6c73db0
> [???71.041037] pgd = ead9c000
> [???71.043747] [b6c73db0] *pgd=3fd72831
> [???84.144056] Unhandled fault: external abort on linefetch (0x014) at 0xb6d44db0
> [...]

I've now tried the debian kernel configuration from sid which is for
4.11. That also has not provoked the issue.

So i'm thinking this has to be related to bits of hardware i'm not
using. I don't have anything on the PCIe bus, i don't have any USB
devices plugged in, i don't use the mtd devices, etc.

Could somebody who does have the issue describe their system? Could
they pull out all there USB devices and see if that stops the
issues. Remove the driver for PCIe devices, if possible.

 Andrew
