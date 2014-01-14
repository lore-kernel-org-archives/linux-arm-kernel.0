From: fkan@apm.com (Feng Kan)
Date: Mon, 13 Jan 2014 16:42:46 -0800
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <201401132043.52491.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <201401131619.35030.arnd@arndb.de>
 <CAL85gmCTsxng3jCaAcCjePE6Pxu7Jg98TDUqQrDFzsfW2GQwEg@mail.gmail.com>
 <201401132043.52491.arnd@arndb.de>
Message-ID: <CAL85gmCA4kBsRUMC_ENjGfCq5jM11iY5Jx_+A3V9XQDU0b7E0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Is this related to the standard ARM SCU that manages multiprocessor
> systems, or a different unit that uses the same name?

FKAN: You mean the snoop control unit in ARM. This is different from
that, the main function of this unit is clk control.

>
> Since this is a global register range with a variety of things in it,
> the best candidate IMHO would be to use the "syscon" driver. You can
> mark the device node as 'compatible="apm,xgene-scu","syscon"' to let
> it get picked up by the drivers/mfd/syscon driver, which creates
> a "regmap" structure for it.
>
> The reset driver then uses a DT reference with a phandle to the
> SCU node and calls syscon_regmap_lookup_by_phandle() to get the
> regmap. It can get the register number inside the regmap from DT
> as well and use the regmap API to perform the reset.

Thanks, will do.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
