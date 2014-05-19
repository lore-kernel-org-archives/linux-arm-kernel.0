From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 19 May 2014 08:57:59 -0300
Subject: [PATCH v5 2/2] ARM: dts: mx51: Remove mach-cpuimx51sd board file
In-Reply-To: <1400492895.2007.7.camel@x220>
References: <1399736856-9489-1-git-send-email-festevam@gmail.com>
 <1399736856-9489-2-git-send-email-festevam@gmail.com>
 <20140513015431.GI8330@dragon> <1400492895.2007.7.camel@x220>
Message-ID: <CAOMZO5ArKGZfqSZurMpsGA28MxNRmqcnYc38G8rR3axVDfwaaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 6:48 AM, Paul Bolle <pebolle@tiscali.nl> wrote:

> This patch just hit linux-next (in next-20140519) as "ARM: mx51: Remove
> mach-cpuimx51sd board file".
>
> It removed the Kconfig symbol MACH_EUKREA_MBIMXSD51_BASEBOARD. But it
> left one reference to that symbol in sound/soc/fsl/Kconfig untouched,
> see:
>
> config SND_SOC_EUKREA_TLV320
>         tristate "Eukrea TLV320"
>         depends on MACH_EUKREA_MBIMX27_BASEBOARD \
>                 || MACH_EUKREA_MBIMXSD25_BASEBOARD \
>                 || MACH_EUKREA_MBIMXSD35_BASEBOARD \
>                 || MACH_EUKREA_MBIMXSD51_BASEBOARD \
>                 || (OF && ARM)
>         depends on I2C
>         select SND_SOC_TLV320AIC23_I2C
>         select SND_SOC_IMX_AUDMUX
>         select SND_SOC_IMX_SSI
>         select SND_SOC_FSL_SSI
>         select SND_SOC_IMX_PCM_DMA
>         help
>           Enable I2S based access to the TLV320AIC23B codec attached
>           to the SSI interface
>
> What should be done with that last reference?

Thanks for reporting.

MACH_EUKREA_MBIMXSD51_BASEBOARD should be removed from sound/soc/fsl/Kconfig.

Would you like to submit a patch?
