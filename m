From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 28 May 2013 16:50:57 +0100
Subject: [RFC] arm64: Add support to pass earlyprintk argument via
 device tree
In-Reply-To: <1369219713-18590-1-git-send-email-pranavkumar@linaro.org>
References: <1369219713-18590-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <20130528155056.GE17912@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 11:48:33AM +0100, Pranavkumar Sawargaonkar wrote:
> This patch adds support for defining and passing earlyprintk
> related information i.e. device and address information via
> device tree by adding it inside "chosen" node.
> 
> This will help user to just specify "earlyprintk" from bootargs
> without actually knowing the address and device to enable
> earlyprintk.
> 
> Mechanism:
> 
> One can just append earlyprintk=device-type,address (same as we pass
> through command line) in "/chosen" node to notify kernel which is the
> earlyprintk device and what is its address.

I think the idea is good but I would like to see some comments from
people more familiar with the DT.

> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -60,6 +60,9 @@ EXPORT_SYMBOL(processor_id);
>  unsigned int elf_hwcap __read_mostly;
>  EXPORT_SYMBOL_GPL(elf_hwcap);
>  
> +char *earlyprintk_dt_args;
> +EXPORT_SYMBOL_GPL(earlyprintk_dt_args);

Why exporting it? Would you expect this to be used from modules?

-- 
Catalin
