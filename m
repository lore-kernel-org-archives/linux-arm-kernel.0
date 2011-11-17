From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 17 Nov 2011 14:48:17 +0400
Subject: [PATCH v3 4/5] ARM: davinci: create new common platform header
 for davinci
In-Reply-To: <1321525138-3928-5-git-send-email-manjunath.hadli@ti.com>
References: <1321525138-3928-1-git-send-email-manjunath.hadli@ti.com>
 <1321525138-3928-5-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4EC4E671.8030105@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-11-2011 14:18, Manjunath Hadli wrote:

> remove the code from individual platform header files for
> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file davinci_common.h.
> Include the new header file in individual platform header
> files as a pre-cursor for deleting these headers in follow
> up patches.

> Signed-off-by: Manjunath Hadli<manjunath.hadli@ti.com>
[...]

> diff --git a/arch/arm/mach-davinci/include/mach/davinci.h b/arch/arm/mach-davinci/include/mach/davinci.h
> new file mode 100644
> index 0000000..49bf2f3
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/davinci.h
> @@ -0,0 +1,88 @@
[...]
> +/* DM355 base addresses */
> +#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
> +#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000

> +/* DM365 base addresses */
> +#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01d10000
> +#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
> +#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000

    Note that DM355/365 EMIF CE0/1 bases are similar -- perhaps it's worth to 
have the single definition for them now, like DM3X5_ASYNC_EMIF_DATA_CE<n>_BASE.

WBR, Sergei
