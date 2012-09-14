From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 15:29:57 +0000
Subject: [PATCH 2/2] ARM: dts: AM33XX: Add lis331dlh device tree data to
 am335x-evm
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2F2B1@DBDE01.ent.ti.com>
References: <1347551685-19781-1-git-send-email-anilkumar@ti.com>
 <201209141028.38185.arnd@arndb.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA2F2B1@DBDE01.ent.ti.com>
Message-ID: <201209141529.57295.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, AnilKumar, Chimata wrote:
> Small question here, in my v2 version I have specified both
> the compatible names lis3lv02d and lis331dlh is it fine or
> only one is sufficient?
> 
> +static struct of_device_id lis3lv02d_i2c_dt_ids[] = {
> +       { .compatible = "st,lis3lv02d" },
> +       { .compatible = "st,lis331dlh" },
> +       {}
> +};
> 

That's ok. In most cases, people will need the data field to point to a
data structure with the differences between two chips, but not if they are
identical from the software side.
It's also fine if you just list one entry here and put both values as
"compatible" in the device tree, to signify that the device is backwards
compatible with the older variant.

	Arnd
