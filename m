From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 18 May 2010 21:20:29 +0900
Subject: [PATCH v3 8/9] ARM: S5PV210: Adds Touchscreen support for S5PV210
In-Reply-To: <1274183102-16168-1-git-send-email-kgene.kim@samsung.com>
References: <1274183102-16168-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTin3WsmSTBN0lubg61s0opV9bTq-tLJ5jcR0Lt8W@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
> ?void __init s5pv210_map_io(void)
> ?{
> + ? ? ? s3c_device_ts.name ? ? ?= "s3c64xx-ts";
> + ? ? ? s3c_device_adc.name ? ? = "s3c64xx-adc";
> +
> ? ? ? ?iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));

Umm recent patches make a code as puzzle. Some codes use the wrapper
some use the *_setname functions.

        /* initialise device information early */
        s5pv210_default_sdhci0();
        s5pv210_default_sdhci1();
        s5pv210_default_sdhci2();
        s5pv210_default_sdhci3();

        /* the i2c devices are directly compatible with s3c2440 */
        s3c_i2c0_setname("s3c2440-i2c");
        s3c_i2c1_setname("s3c2440-i2c");
        s3c_i2c2_setname("s3c2440-i2c");

and finally assign the 'name' directly.

At some time later. Who know and remember the proper assignments for new SoCs.

Thank you,
Kyungmin Park
