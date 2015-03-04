From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Mar 2015 17:39:35 +0100
Subject: [PATCH v2 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT
 bindings documentation
In-Reply-To: <1425284686-5116-3-git-send-email-wens@csie.org>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-3-git-send-email-wens@csie.org>
Message-ID: <20150304163935.GO4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:24:44PM +0800, Chen-Yu Tsai wrote:
> Reduced Serial Bus (RSB) is an SMBus like bus used to communicate
> with some PMICs (like the AXP223) or other peripherals.
> 
> The RSB DT bindings are pretty much the same as the one defined for
> the marvell's mv64xxx controller, with the additional RSB specific
> "allwinner,rsb-hw-addr" property for slave device nodes.
> 
> There are 2 types of addresses for RSB devices, a hardware address
> and a runtime (software) configurable address. The former is only
> used when configuring the latter. All read/write accesses use the
> runtime address.
> 
> It would seem straightforward to use the hardware address in the
> DT bindings as the slave's address. However this will not work as
> the hardware address is 12 bits wide, and at least 1 device, the
> AC100 audio codec, has the highest bit set. This address would be
> incompatible with I2C (7 or 10 bit addresses) and likely rejected.
> 
> Hence this binding uses statically allocated (by the author of the
> DT) runtime addresses for the slave's "reg" property. The hardware
> address is put in a separete named property. When writing a new DT,
                      ^ separate
> the author must take care to not have multiple slave devices use
> the same address. It is recommended to follow whatever conventions
> the hardware vendor uses.

While very complete, the three last paragraphs should rather be, or at
least duplicated, in the file itself.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/0c8967a8/attachment.sig>
