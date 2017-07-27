From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 12:54:00 +0200
Subject: [v4.13-rc1 fixes] ARM: dts: exynos: Add clocks to audss block to
 fix silent hang on Exynos4412
In-Reply-To: <20170717194527.16559-1-krzk@kernel.org>
References: <20170717194527.16559-1-krzk@kernel.org>
Message-ID: <CAK8P3a35EbCtHbe_fnFxs2206jbDewyL_Awzm1fgZHz9qFTNGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 9:45 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Add necessary parent clocks for audss (Audio SubSystem, MAUDIO) clock
> controller block.
>
> This allows driver to keep EPLL enabled before accessing any MAUDIO
> registers thus fixing silent hang.  This silent hang appeared with
> commit 6edfa11cb396 ("clk: samsung: Add enable/disable operation for
> PLL36XX clocks"), e.g. on Odroid U3 usually with last (but unrelated)
> messages:
>
>         [    2.382741] input: gpio_keys as /devices/platform/gpio_keys/input/input0
>         [    2.405686] usb 1-3: new high-speed USB device number 3 using exynos-ehci
>         [    2.419843] max77686-rtc max77686-rtc: setting system clock to 2017-06-21 17:04:13 UTC (1498064653)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>
> Hi Arnd, Olof,
>
> I have only one patch in fixes queue for v4.13, so how about applying this
> directly without a pull request?

No problem, I was just a little slow here. Applied to fixes now, thanks.

      Arnd
