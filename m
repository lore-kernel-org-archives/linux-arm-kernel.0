From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 10:44:51 +0100
Subject: [RFC/PATCH 1/4] ARM: mvebu: use dt_fixup to provide fallback for
 enable-method
In-Reply-To: <1418179187-18486-2-git-send-email-chris.packham@alliedtelesis.co.nz>
References: <1418179187-18486-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <1418179187-18486-2-git-send-email-chris.packham@alliedtelesis.co.nz>
Message-ID: <2128384.mZxE73eTGk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 December 2014 15:39:44 Chris Packham wrote:
> 
> +static void __init armada_370_xp_dt_fixup(void)
> +{
> +       smp_set_ops(smp_ops(armada_xp_smp_ops));
> +}
> +
> 

The dt_fixup callback pointer is meant to fix up a legacy dtb file in
memory. I think this would be fairly easy in this case, just add in the
missing enable-method property here to make the normal boot path
work for old dtbs.

	Arnd
