From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Feb 2018 10:04:01 +0100
Subject: [PATCH v3 1/7] ARM: sun8i: smp: Add support for A83T
In-Reply-To: <20180219081837.15482-2-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-2-mylene.josserand@bootlin.com>
Message-ID: <20180219090401.5uxmwtnkd7oadaxx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 19, 2018 at 09:18:31AM +0100, Myl?ne Josserand wrote:
> Add the support for A83T.
> 
> A83T SoC has an additional register than A80 to handle CPU configurations:
> R_CPUS_CFG. Information about the register comes from Allwinner's BSP
> driver.
> An important difference is the Power Off Gating register for clusters
> which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>

This is some high-level review, but you should split this patch in
three:
  - One to refactor the current code to split the DT parsing function
    (and rename the function to sun9i_smp_dt_parse) and the variable renames
  - One to enable the A83t SMP (with the function called sun8i_a83t_smp_dt_parse)
  - One to enable the A83t hotplug (merged with your last patch)

Also, you're calling a lot of times of_machine_is_compatible, and this
is quite inefficient. You should call it once and store the result.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/1af9d3d5/attachment.sig>
