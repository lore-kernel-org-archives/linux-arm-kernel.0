From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 May 2013 15:23:05 +0800
Subject: [PATCH v3] tty: serial: add Freescale lpuart driver support
In-Reply-To: <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
Message-ID: <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2013 14:40, Jin Zhengxiong-R64188 <R64188@freescale.com> wrote:
> [Jason Jin-R64188] Reuse the same LPUART on LS-1 with the compatible strings 'fsl,mvf600-lpuart' is technically OK, But it will fuss the route map of the product Line. The general name can show that the IP is shared between several product lines, and the history for which SOC firstly used the IP is not very important. With general compatible name, We can setup the general dts for the shared IPs.
>
> That's also the case for the IPs used on Power platform, Take the IFC for example, this IP implemented on Power platform will also be reused LS-1, The compatible string is set as  "fsl,ifc", "simple-bus" but not the soc name on which the IP first used.
>
>  Another example, though a little different, the nor flash driver, which is used for many platform, the compatible "cfi-flash" will be more reasonable than the soc/board name.
>
> With the general name for the compatible string in the driver, if there is minor difference for the different implementation of the same IP, we can add the soc related compatible string to the driver to pass different .data structure for that soc.
>

As I already said, a generic compatible string does not specify
anything about compatibility/version, and hence it's not a good
compatible for IP block which is possibly to be integrated on multiple
SoCs with slight differences.

For example, if there is a new SoC mvf900 integrating the IP with
everything compatible to the version used on mvf600,

  compatible = <fsl,mvf900-uart>, <fsl,mvf600-uart>;
  compatible = <fsl,mvf900-uart>, <fsl,lpuart>;

which one do you think is better to tell the compatibility/version?

Shawn
