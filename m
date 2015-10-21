From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 21 Oct 2015 17:04:45 -0500
Subject: [PATCH 02/19] Documentation: devicetree: fix reference to legacy
 wakeup properties
In-Reply-To: <1445422216-29375-3-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqJ+5RNCehN9izgChf1fXhctzf+ShevjdAGnW5jF1GsAXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 5:09 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> This patch marks all the reference to the legacy wakeup bindings
> and replaces them with the standard "wakeup-source" property.
>
> All these legacy property are also listed under a separate section in
> the generic wakeup-source binding document.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/crypto/fsl-sec4.txt          |  4 ++--
>  Documentation/devicetree/bindings/input/ads7846.txt            |  3 ++-
>  Documentation/devicetree/bindings/input/gpio-keys-polled.txt   |  1 +
>  Documentation/devicetree/bindings/input/gpio-keys.txt          |  1 +
>  Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt |  1 +
>  Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt |  3 ++-
>  Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt |  1 +
>  Documentation/devicetree/bindings/input/samsung-keypad.txt     |  3 ++-
>  Documentation/devicetree/bindings/mfd/tc3589x.txt              |  1 +
>  Documentation/devicetree/bindings/mmc/mmc.txt                  |  5 +++--
>  Documentation/devicetree/bindings/rtc/isil,isl12057.txt        | 10 +++++-----
>  Documentation/devicetree/bindings/rtc/rtc-opal.txt             |  5 +++--
>  12 files changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> index 6831d025ec24..adeca34c5a33 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> @@ -441,7 +441,7 @@ System ON/OFF key driver
>                 regmap = <&snvs>;
>                 interrupts = <0 4 0x4>
>                 linux,keycode = <116>; /* KEY_POWER */
> -               wakeup;
> +               wakeup-source;
>         };
>
>  =====================================================================
> @@ -530,7 +530,7 @@ FULL EXAMPLE
>                         regmap = <&sec_mon>;
>                         interrupts = <0 4 0x4>;
>                         linux,keycode = <116>; /* KEY_POWER */
> -                       wakeup;
> +                       wakeup-source;
>                 };
>         };
>
> diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
> index df8b1279491d..33a1638b61d6 100644
> --- a/Documentation/devicetree/bindings/input/ads7846.txt
> +++ b/Documentation/devicetree/bindings/input/ads7846.txt
> @@ -65,6 +65,7 @@ must be specified.
>         pendown-gpio                    GPIO handle describing the pin the !PENIRQ
>                                         line is connected to.
>         wakeup-source                   use any event on touchscreen as wakeup event.
> +                                       (Legacy property support: "linux,wakeup")
>
>
>  Example for a TSC2046 chip connected to an McSPI controller of an OMAP SoC::
> @@ -86,6 +87,6 @@ must be specified.
>                         ti,x-plate-ohms = /bits/ 16 <40>;
>                         ti,pressure-max = /bits/ 16 <255>;
>
> -                       linux,wakeup;
> +                       wakeup-source;
>                 };
>         };
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> index 5b91f5a3bd5c..d698475a9262 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
> @@ -21,6 +21,7 @@ Device-Tree bindings for input/gpio_keys_polled.c keyboard driver
>         - debounce-interval: Debouncing interval time in milliseconds.
>           If not specified defaults to 5.
>         - wakeup-source: Boolean, button can wake-up the system.
> +                        (Legacy property supported: "gpio-key,wakeup")
>
>  Example nodes:
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index 072bf7573c37..cf1333d1dd52 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -24,6 +24,7 @@ both at the same time. Specifying both properties is allowed.
>         - debounce-interval: Debouncing interval time in milliseconds.
>           If not specified defaults to 5.
>         - wakeup-source: Boolean, button can wake-up the system.
> +                        (Legacy property supported: "gpio-key,wakeup")
>         - linux,can-disable: Boolean, indicates that button is connected
>           to dedicated (not shared) interrupt which can be disabled to
>           suppress events from the button.
> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> index 4d86059c370c..d0ea09ba249f 100644
> --- a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> @@ -20,6 +20,7 @@ report the event using GPIO interrupts to the cpu.
>  Optional Properties:
>  - linux,no-autorepeat: do no enable autorepeat feature.
>  - wakeup-source:       use any event on keypad as wakeup event.
> +                       (Legacy property supported: "linux,wakeup")
>  - debounce-delay-ms:   debounce interval in milliseconds
>  - col-scan-delay-us:   delay, measured in microseconds, that is needed
>                         before we can scan keypad after activating column gpio
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> index 0382b8bd69c6..1faa7292e21f 100644
> --- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> +++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> @@ -29,7 +29,8 @@ Optional properties, in addition to those specified by the shared
>  - nvidia,debounce-delay-ms: delay in milliseconds per row scan for debouncing
>  - nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
>  - nvidia,ghost-filter: enable ghost filtering for this device
> -- nvidia,wakeup-source: configure keyboard as a wakeup source for suspend/resume
> +- wakeup-source: configure keyboard as a wakeup source for suspend/resume
> +                (Legacy property supported: "nvidia,wakeup-source")
>
>  Example:
>
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
> index ee6215681182..4a9dc6ba96b1 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
> @@ -37,6 +37,7 @@ PROPERTIES
>         Usage: optional
>         Value type: <bool>
>         Definition: use any event on keypad as wakeup event.
> +                   (Legacy property supported: "linux,keypad-wakeup")
>
>  - keypad,num-rows:
>         Usage: required
> diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> index 863e77f619dc..5305e74e5742 100644
> --- a/Documentation/devicetree/bindings/input/samsung-keypad.txt
> +++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
> @@ -38,6 +38,7 @@ event using a interrupt to the cpu.
>
>  Optional Properties:
>  - wakeup-source: use any event on keypad as wakeup event.
> +                (Legacy property supported: "linux,input-wakeup")
>
>  Optional Properties specific to linux:
>  - linux,keypad-no-autorepeat: do no enable autorepeat feature.
> @@ -51,7 +52,7 @@ event using a interrupt to the cpu.
>                 samsung,keypad-num-rows = <2>;
>                 samsung,keypad-num-columns = <8>;
>                 linux,input-no-autorepeat;
> -               linux,input-wakeup;
> +               wakeup-source;
>
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&keypad_rows &keypad_columns>;
> diff --git a/Documentation/devicetree/bindings/mfd/tc3589x.txt b/Documentation/devicetree/bindings/mfd/tc3589x.txt
> index 37bf7f1aa70a..23fc2f21f5a4 100644
> --- a/Documentation/devicetree/bindings/mfd/tc3589x.txt
> +++ b/Documentation/devicetree/bindings/mfd/tc3589x.txt
> @@ -56,6 +56,7 @@ following built-in devices: gpio, keypad, rotator (vibrator), PWM (for
>     bindings/input/matrix-keymap.txt
>   - linux,no-autorepeat: do no enable autorepeat feature.
>   - wakeup-source: use any event on keypad as wakeup event.
> +                 (Legacy property supported: "linux,wakeup")
>
>  Example:
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 0384fc3f64e8..a88f5dc775bd 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -67,7 +67,8 @@ polarity is in effect.
>
>  Optional SDIO properties:
>  - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
> -- enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
> +- wakeup-source: Enables wake up of host system on SDIO IRQ assertion
> +                (Legacy property supported: "enable-sdio-wakeup")
>
>
>  MMC power sequences:
> @@ -117,7 +118,7 @@ sdhci at ab000000 {
>         wp-gpios = <&gpio 70 0>;
>         max-frequency = <50000000>;
>         keep-power-in-suspend;
> -       enable-sdio-wakeup;
> +       wakeup-source;
>         mmc-pwrseq = <&sdhci0_pwrseq>
>  }
>
> diff --git a/Documentation/devicetree/bindings/rtc/isil,isl12057.txt b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
> index 501c39ceae79..cf83e0940302 100644
> --- a/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
> +++ b/Documentation/devicetree/bindings/rtc/isil,isl12057.txt
> @@ -5,7 +5,7 @@ consisting of a compatible field, an address and possibly an interrupt
>  line).
>
>  Nonetheless, it also supports an option boolean property
> -("isil,irq2-can-wakeup-machine") to handle the specific use-case found
> +("wakeup-source") to handle the specific use-case found
>  on at least three in-tree users of the chip (NETGEAR ReadyNAS 102, 104
>  and 2120 ARM-based NAS); On those devices, the IRQ#2 pin of the chip
>  (associated with the alarm supported by the driver) is not connected
> @@ -22,9 +22,9 @@ can wake up the device.
>
>  Optional properties:
>
> - - "isil,irq2-can-wakeup-machine": mark the chip as a wakeup source,
> -   independently of the availability of an IRQ line connected to the
> -   SoC.
> + - "wakeup-source": mark the chip as a wakeup source, independently of
> +    the availability of an IRQ line connected to the SoC.
> +    (Legacy property supported: "isil,irq2-can-wakeup-machine")
>
>   - "interrupt-parent", "interrupts": for passing the interrupt line
>     of the SoC connected to IRQ#2 of the RTC chip.
> @@ -74,5 +74,5 @@ Example isl12057 node without IRQ#2 pin connected to the SoC but to a
>         isl12057: isl12057 at 68 {
>                 compatible = "isil,isl12057";
>                 reg = <0x68>;
> -               isil,irq2-can-wakeup-machine;
> +               wakeup-source;
>         };
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-opal.txt b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> index af87e5ecac54..a1734e5cb75b 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> @@ -5,12 +5,13 @@ IBM OPAL real-time clock
>  - comapatible: Should be "ibm,opal-rtc"
>
>  Optional properties:
> -- has-tpo: Decides if the wakeup is supported or not.
> +- wakeup-source: Decides if the wakeup is supported or not
> +                (Legacy property supported: "has-tpo")
>
>  Example:
>         rtc {
>                 compatible = "ibm,opal-rtc";
> -               has-tpo;
> +               wakeup-source;
>                 phandle = <0x10000029>;
>                 linux,phandle = <0x10000029>;
>         };
> --
> 1.9.1
>
