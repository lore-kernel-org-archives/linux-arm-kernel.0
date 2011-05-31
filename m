From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 31 May 2011 23:11:14 +0400
Subject: [PATCH v6 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
	<1305637877-24436-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DE53D52.4040508@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Marc Zyngier wrote:

> In the process of moving platforms away from integrator-flash
> (aka armflash), add to physmap the few features that make
> armflash unique:

> - optionnal probing for the AFS partition type
> - init() and exit() methods, used by Integrator to control
>   write access to the various onboard programmable components

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
[...]

> diff --git a/include/linux/mtd/physmap.h b/include/linux/mtd/physmap.h
> index bcfd9f7..d37cca0 100644
> --- a/include/linux/mtd/physmap.h
> +++ b/include/linux/mtd/physmap.h
> @@ -22,6 +22,8 @@ struct map_info;
>  
>  struct physmap_flash_data {
>  	unsigned int		width;
> +	int			(*init)(struct platform_device *);
> +	void			(*exit)(struct platform_device *);

    How about a declaration for 'struct platform_device' beforehand? This breaks 
build on other platforms at least...

WBR, Sergei
