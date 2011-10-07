From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 7 Oct 2011 11:47:15 +0800
Subject: [PATCH 05/26] ARM: pxa: make zylonite_pxa*_init declaration match
	code
In-Reply-To: <1317499438-14058-6-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-6-git-send-email-arnd@arndb.de>
Message-ID: <CAMPhdO8JMKc8kfBRUPs=80as37z8Gavrt+EEOGYyGMUnG1WHbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When support for zylonite is disabled, the zylonite_pxa300_init
> and zylonite_pxa320_init functions are not there, but the declaration
> is still kept around if any other boards for the same soc are
> enabled. This changes the declaration to be conditional on the
> same symbol as the code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

> ---
> ?arch/arm/mach-pxa/include/mach/zylonite.h | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h b/arch/arm/mach-pxa/include/mach/zylonite.h
> index ea24998..ecca976 100644
> --- a/arch/arm/mach-pxa/include/mach/zylonite.h
> +++ b/arch/arm/mach-pxa/include/mach/zylonite.h
> @@ -19,7 +19,7 @@ extern int wm9713_irq;
> ?extern int lcd_id;
> ?extern int lcd_orientation;
>
> -#ifdef CONFIG_CPU_PXA300
> +#ifdef CONFIG_MACH_ZYLONITE300
> ?extern void zylonite_pxa300_init(void);
> ?#else
> ?static inline void zylonite_pxa300_init(void)
> @@ -29,7 +29,7 @@ static inline void zylonite_pxa300_init(void)
> ?}
> ?#endif
>
> -#ifdef CONFIG_CPU_PXA320
> +#ifdef CONFIG_MACH_ZYLONITE320
> ?extern void zylonite_pxa320_init(void);
> ?#else
> ?static inline void zylonite_pxa320_init(void)
> --
> 1.7.5.4
>
>
