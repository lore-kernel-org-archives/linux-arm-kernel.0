From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 14 May 2014 10:23:44 +0300
Subject: [PATCH v2] usb: phy: msm: reset controller is mandatory now
In-Reply-To: <4319810.IibMxJ0Qvk@wuerfel>
References: <4319810.IibMxJ0Qvk@wuerfel>
Message-ID: <1400052224.8431.11.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-05-13 at 21:46 +0200, Arnd Bergmann wrote:
> Commit a27345434134 "usb: phy: msm: Use reset framework for LINK
> and PHY resets" introduced a mandatory call to reset_control_get
> into the msm usb phy driver, which means we have to add a Kconfig
> dependency on the API to avoid this build error:
> 
> phy/phy-msm-usb.c: In function 'msm_otg_read_dt':
> phy/phy-msm-usb.c:1461:2: error: implicit declaration of function 'devm_reset_control_get' [-Werror=implicit-function-declaration]
>   motg->link_rst = devm_reset_control_get(&pdev->dev, "link");
>   ^
> 
> Since the usb-ehci-msm driver currently selects the OTG driver,
> we could still get a broken dependency here. To solve that,
> this patch also removes the 'select', which turns out to be
> unnecessary.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>

Thank you.

Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>
