From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 29 May 2018 16:11:06 -0700
Subject: [PATCH] soc: imx: gpcv2: correct PGC offset
In-Reply-To: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
References: <1527580944-10043-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAHQ1cqF1-zkR_wQgRK1M3Wd+Hvha+St3jT=-Qvn1RM8N88qW8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 1:02 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Correct MIPI/PCIe/USB_HSIC's PGC offset based on
> design RTL, the value on Reference Manual are incorrect.
>

Nit: I'd s/the value on/the values in the/ here.

> The correct offset should be as below:
>
> 0x800 ~ 0x83F: PGC for core0 of A7 platform;
> 0x840 ~ 0x87F: PGC for core1 of A7 platform;
> 0x880 ~ 0x8BF: PGC for SCU of A7 platform;
> 0xA00 ~ 0xA3F: PGC for fastmix/megamix;
> 0xC00 ~ 0xC3F: PGC for MIPI PHY;
> 0xC40 ~ 0xC7F: PGC for PCIe_PHY;
> 0xC80 ~ 0xCBF: PGC for USB OTG1 PHY;
> 0xCC0 ~ 0xCFF: PGC for USB OTG2 PHY;
> 0xD00 ~ 0xD3F: PGC for USB HSIC PHY;
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index afc7ecc..132c946 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -40,9 +40,9 @@
>  #define GPC_M4_PU_PDN_FLG              0x1bc
>
>
> -#define PGC_MIPI                       4
> -#define PGC_PCIE                       5
> -#define PGC_USB_HSIC                   8
> +#define PGC_MIPI                       16
> +#define PGC_PCIE                       17
> +#define PGC_USB_HSIC                   20

As a suggestion, please add a comment explicitly saying that those
values might differ from what some version of the RM might specify.
Explanation in commit message is great, but seeing a note in the code
might save quite a bit of digging for someone who is reading the code,
double checking those values and thinking that they might be wrong.

Other than that:

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks,
Andrey Smirnov
