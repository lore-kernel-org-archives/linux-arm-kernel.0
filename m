From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 21:53:46 +0800
Subject: [linux-sunxi] [PATCH v2] ARM: dts: sun7i: Correct USB regulators
 on pcDuino v3 Nano
In-Reply-To: <1444481572-13617-1-git-send-email-ats@offog.org>
References: <1444481572-13617-1-git-send-email-ats@offog.org>
Message-ID: <CAGb2v64D7E2pRPyL_=eUp1fHMX1=_UAtLODm1AACAjsVGm8Zsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 8:52 PM, Adam Sampson <ats@offog.org> wrote:
> The LinkSprite pcDuino v3 Nano's two USB host ports are powered by a
> single RT9701GB regulator, which has its enable input tied to the A20's
> PD2 pin, pulled up to 3v3 via a 10k resistor.
>
> However, the script.bin that shipped with the device listed PH11 and PH3
> as Vbus control pins for the two USB ports. Neither of these are
> actually connected to anything.
>
> Siarhei Siamashka spotted this problem while reviewing the other
> LinkSprite boards. This patch fixes it by only defining a single
> regulator, controlled by PD2. Testing shows that the USB ports are now
> (correctly) only powered up once the USB PHY driver is loaded.
>
> Reported-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> Signed-off-by: Adam Sampson <ats@offog.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
