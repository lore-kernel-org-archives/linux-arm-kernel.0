From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 28 Feb 2017 21:43:09 +0100
Subject: [PATCH 1/2] ARM: dts: bcm5301x: Add TWD WD Support to DT
In-Reply-To: <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
References: <1488313886-17155-1-git-send-email-jon.mason@broadcom.com>
 <1488313886-17155-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <CACna6rw1oeUn=QuD-c+X8uokypSEqXUP3yqmiMEK2wgMD-ENeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 February 2017 at 21:31, Jon Mason <jon.mason@broadcom.com> wrote:
> @@ -70,10 +70,19 @@
>                         clocks = <&periph_clk>;
>                 };
>
> -               local-timer at 20600 {
> +               timer at 20600 {

Is there a reason for this rename? I don't really have preference for
any name, it's just we shouldn't keep renaming this depending of
personal preferences.

It also doesn't seem like adjusting to any schema:
bcm63138.dtsi uses local-timer at 1e600
bcm-nsp.dtsi uses twd-timer at 20600
berlin2cd.dtsi uses local-timer at ad0600
berlin2.dtsi uses local-timer at ad0600
berlin2q.dtsi uses local-timer at ad0600


>                         compatible = "arm,cortex-a9-twd-timer";
> -                       reg = <0x20600 0x100>;
> -                       interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +                       reg = <0x20600 0x20>;
> +                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +                                                 IRQ_TYPE_LEVEL_HIGH)>;
> +                       clocks = <&periph_clk>;
> +               };

The rest looks OK, thanks! :)

-- 
Rafa?
