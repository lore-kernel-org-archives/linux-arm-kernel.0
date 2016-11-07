From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2016 18:27:35 +0000
Subject: [PATCH] arm/vdso: introduce vdso_mremap hook
In-Reply-To: <20161101172214.2938-1-dsafonov@virtuozzo.com>
References: <20161101172214.2938-1-dsafonov@virtuozzo.com>
Message-ID: <20161107182734.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2016 at 08:22:14PM +0300, Dmitry Safonov wrote:
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index 53cf86cf2d1a..d1001f87c2f6 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -54,8 +54,11 @@ static const struct vm_special_mapping vdso_data_mapping = {
>  	.pages = &vdso_data_page,
>  };
>  
> +static int vdso_mremap(const struct vm_special_mapping *sm,
> +		struct vm_area_struct *new_vma);

I'd much rather avoid this forward declaration.  Is there any reason the
function body can't be here?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
