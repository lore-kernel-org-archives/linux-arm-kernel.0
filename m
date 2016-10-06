From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 6 Oct 2016 20:23:03 +0200
Subject: [PATCH 06/14] ASoC: Add sun8i digital audio codec
In-Reply-To: <901741475770017@web21g.yandex.ru>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004161549.GO5228@lukather> <901741475770017@web21g.yandex.ru>
Message-ID: <20161006182303.sftz3c7hjhv7xell@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2016 at 00:06:57 +0800, Icenowy Zheng wrote :
> 05.10.2016, 00:20, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> >> ?+static const struct of_device_id sun8i_codec_of_match[] = {
> >> ?+ { .compatible = "allwinner,sun8i-a33-codec" },
> >> ?+ { .compatible = "allwinner,sun8i-a23-codec" },
> >
> > I thought that the A23 and A33 had different codecs? In that case, it
> > wouldn't be a good assumption to make
> 
> Yes.
> 
> >
> >> ?+ {}
> >> ?+};
> >> ?+MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> >> ?+
> >> ?+static struct platform_driver sun8i_codec_driver = {
> >> ?+ .driver = {
> >> ?+ .name = "sun8i-codec",
> >> ?+ .owner = THIS_MODULE,
> >> ?+ .of_match_table = sun8i_codec_of_match,
> >> ?+ },
> >> ?+ .probe = sun8i_codec_probe,
> >> ?+ .remove = sun8i_codec_remove,
> >> ?+};
> >> ?+module_platform_driver(sun8i_codec_driver);
> >> ?+
> >> ?+MODULE_DESCRIPTION("Allwinner A33 (sun8i) codec driver");
> >> ?+MODULE_AUTHOR("huanxin<huanxin@reuuimllatech.com>");
> >
> > Those obfuscated email adresses are not really helpful :)
> 
> This kind of email addresses  are kept in many places in mainline kernel.
> 
> e.g. drivers/mmc/host/sunxi-mmc.c have 'Aaron Maoye <leafy.myeh@reuuimllatech.com>'
> 

Well, that is only one place and it is a comment, not in the
MODULE_AUTHOR macro. I would agree that it is not useful to have a stale
email address in MODULE_AUTHOR.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
