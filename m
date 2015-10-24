From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 24 Oct 2015 23:44:55 +0200
Subject: [PATCH v2 1/4] DT: nvmem: Add NXP LPC18xx EEPROM memory binding
 documentation
In-Reply-To: <1445275946-32653-2-git-send-email-ariel@vanguardiasur.com.ar>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1445275946-32653-2-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VyCBTWh6qgZ__eNLqooNURsYr9ZVtDz2qCKoa0MoVgXtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ariel,

On 19 October 2015 at 19:32, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> Add the devicetree binding document for NXP LPC18xx EEPROM memory.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  .../devicetree/bindings/nvmem/lpc1857-eeprom.txt   | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
>
> diff --git a/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt b/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
> new file mode 100644
> index 0000000..01cde0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/lpc1857-eeprom.txt
> @@ -0,0 +1,26 @@
> +* NXP LPC18xx EEPROM memory NVMEM driver
> +
> +Required properties:
> +  - compatible: Should be "nxp,lpc1857-eeprom"
> +  - reg: Must contain an entry with the physical base address and length
> +    for each entry in reg-names.
> +  - reg-names: Must include the following entries.
> +    - reg: EEPROM registers.
> +    - mem: EEPROM address space.
> +  - clocks: Must contain an entry for each entry in clock-names.
> +  - clock-names: Must include the following entries.
> +    - eeprom: EEPROM operating clock.
> +  - interrupts: Should contain EEPROM interrupt.

You should document the 'reset' property as well.

> +Example:
> +
> +  eeprom: eeprom at 4000e000 {
> +    compatible = "nxp,lpc1857-eeprom";
> +    reg = <0x4000e000 0x1000>,
> +          <0x20040000 0x4000>;
> +    reg-names = "reg", "mem";
> +    clocks = <&ccu1 CLK_CPU_EEPROM>;
> +    clock-names = "eeprom";
> +    resets = <&rgu 27>;
> +    interrupts = <4>;
> +  };

Other than that this looks good to me.

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
