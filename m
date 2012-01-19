From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 Jan 2012 17:27:15 +0000
Subject: [PATCH v6 9/9] ARM: vexpress: Add Device Tree for V2P-CA15 core
 tile (TC1 variant)
In-Reply-To: <4F184C48.2050505@citrix.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-10-git-send-email-pawel.moll@arm.com>
 <4F0C495C.4000103@citrix.com>
 <1326979652.32197.66.camel@hornet.cambridge.arm.com>
 <4F181BD9.20401@gmail.com>
 <1326980594.32197.67.camel@hornet.cambridge.arm.com>
 <4F182248.7070209@gmail.com>
 <1326984672.32197.68.camel@hornet.cambridge.arm.com>
 <4F184C48.2050505@citrix.com>
Message-ID: <1326994035.13748.7.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-01-19 at 17:00 +0000, David Vrabel wrote:
> The problem wasn't with including skeleton.dtsi.  

Including as it is creates two device_type="memory" nodes, one with
regs=<0 0>, which is definitely wrong.

> With
> CONFIG_ARM_ATAG_DTB_COMPAT the zImage decompressor modifies the appended
> DTB using information from the ATAGs (see atags_to_fdt()).
> 
> If there's an ATAG giving the amount of RAM the DTB's "memory" node is
> replaced with a new one.  Since the vexpress DTBs don't have a "memory"
> node it's added and the DTB ends up with two nodes describing memory.

The "memory at address" node name is in my opinion perfectly legal - p. 3.4
of the DT spec says "The name component of the node name (see 2.2.1)
shall be memory.". So the decompressor code may be wrong in looking for
adress-less "memory" node...

One way or the other, I'll get this fixed.

Thanks for letting me know!

Pawe?
