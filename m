From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2016 15:36:34 +0200
Subject: [PATCH 2/4 v2] soc: qcom: add EBI2 driver
In-Reply-To: <CACRpkdZHHGZaaxym9f-3mGREmokRhgNm3yb_HxaP0=_iuZNk1g@mail.gmail.com>
References: <1472028758-29272-1-git-send-email-linus.walleij@linaro.org>
 <201608291520.07798.arnd@arndb.de>
 <CACRpkdZHHGZaaxym9f-3mGREmokRhgNm3yb_HxaP0=_iuZNk1g@mail.gmail.com>
Message-ID: <201608291536.34501.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 August 2016, Linus Walleij wrote:
> >> +static struct platform_driver qcom_ebi2_driver = {
> >> +     .probe = qcom_ebi2_probe,
> >> +     .driver = {
> >> +             .name = "qcom-ebi2",
> >> +             .of_match_table = qcom_ebi2_of_match,
> >> +     },
> >> +};
> >> +builtin_platform_driver(qcom_ebi2_driver);
> >
> > Why not allow this to be a loadable module?
> 
> I don't see any point in it, it's so basic to be able to access the
> MMIO devices on the platform, the plan was to select the driver
> from the corresponding mach-qcom SoC type (MSM8660+APQ8060).
> 
> But I can make it a module instead, if preferred.

Ok, I expected this to be only for rare optional devices such as
NOR flash or the ethernet device from your example. If this is required
for booting a system, making it a module won't help much.

	Arnd
