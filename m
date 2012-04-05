From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 5 Apr 2012 18:41:43 -0400
Subject: [PATCH 4/7 v4] ARM: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <1333663656.12209.62.camel@dagon.hellion.org.uk>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
 <1333663656.12209.62.camel@dagon.hellion.org.uk>
Message-ID: <20120405224143.GL817@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 11:07:36PM +0100, Ian Campbell wrote:
> On Tue, 2012-03-13 at 01:57 +0000, Jason Cooper wrote:
> > +DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)") 
> 
> This ends up as Machine: in /proc/cpuinfo, which seems to be normal?
> 
> Would it be worth trying to dynamically modify the machine string based
> on the actual hardware the kernel is running on?

With CONFIG_PROC_DEVICETREE=y I get the following:

$ cat /proc/device-tree/model
Globalscale Technologies Dreamplug

It seems to me (I have no strong opinion here, just playing devil's
advocate) that /proc/cpuinfo is indeed telling us about the processor
(Marvell Kirkwood ...) Should it really be describing the board?

thx,

Jason.
