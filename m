From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 May 2017 17:05:49 -0700
Subject: [PATCH v2] arm64: defconfig: enable some core options for 64bit
 Rockchip socs
In-Reply-To: <20170524230650.17849-1-heiko@sntech.de>
References: <20170524230650.17849-1-heiko@sntech.de>
Message-ID: <20170526000549.GB28071@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 01:06:50AM +0200, Heiko Stuebner wrote:
> Enable some very core config options used on 64bit Rockchip socs.
> 
> As built-in driver enable the Rockchip spi driver as well as the
> cros-ec-spi and cros-ec keyboard driver, as this may be helpful
> in case an initrd does not work as expected and drops the user
> into a shell. Another built-in is the fan53555 regulator driver,
> as it and its register-compatible cousins Silergy syr827 and syr828
> are often used on Rockchip socs as cpu-supply next to regular pmic.
> 
> The rest can be enabled as modules and contains the pcie host
> controller and its phy, the sucessive approximation adc (saradc)
> that gets often used for additional buttons on Rockchip boards
> as well as the adc-keys Keyboard driver for these keys.
> 
> The cros-ec-pwm also can be a module, as it is normally only used to
> drive display backlights as well as the Rockchip thermal controller
> that allows to read the cpu and gpu temperatures and affect frequency
> scaling if necessary.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Applied to fixes for 4.12, since it seems beneficial to have the defconfig
work well on Rockchip there.


-Olof
