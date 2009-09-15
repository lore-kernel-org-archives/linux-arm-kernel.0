From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:17:16 +0100
Subject: [PATCH 01/10] S3C64XX I2S: S3C64XX_PA_IISV4 defined
In-Reply-To: <1253008953-10441-1-git-send-email-jassi.brar@samsung.com>
References: <1253008953-10441-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915101716.GE22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:33PM +0900, Jassi wrote:
> Defined the missing S3C64XX_PA_IISV4 conditionally for 6410 as
> it's not avaialble for 6400

> Signed-Off-by: Jassi <jassi.brar@samsung.com>

>  #define S3C64XX_PA_IIS1		(0x7F003000)
> +#ifdef CONFIG_CPU_S3C6410
> +#define S3C64XX_PA_IISV4	(0x7F00D000)
> +#endif

I'm not sure what the roadmap for future CPUs looks like but might this
better done with the inverse test so we don't have to add every single
new CPU to the ifdefs.  TBH I'm not sure if the ifdefs are worth it.
