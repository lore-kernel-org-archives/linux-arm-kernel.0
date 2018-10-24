From: leoyang.li@nxp.com (Li Yang)
Date: Wed, 24 Oct 2018 16:39:35 -0500
Subject: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
In-Reply-To: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
 <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87000000,
>           .mask         = 0xfff70000,
>         },
> +       /* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +       { .die          = "LX2160A",
> +         .svr          = 0x87360000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1088a-dcfg", },
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
> +       { .compatible = "fsl,lx2160a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>
