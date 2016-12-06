From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 6 Dec 2016 12:42:10 -0800
Subject: [PATCH 3/3] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161206195312.22354-4-f.fainelli@gmail.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <20161206195312.22354-1-f.fainelli@gmail.com>
 <20161206195312.22354-4-f.fainelli@gmail.com>
Message-ID: <2c5c5fe5-ad79-35f8-95b4-32c5653ddd5c@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2016 11:53 AM, Florian Fainelli wrote:
> x86 has an option: CONFIG_DEBUG_VIRTUAL to do additional checks on
> virt_to_phys calls. The goal is to catch users who are calling
> virt_to_phys on non-linear addresses immediately. This includes caller
> using __virt_to_phys() on image addresses instead of __pa_symbol(). This
> is a generally useful debug feature to spot bad code (particulary in
> drivers).
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

> @@ -261,6 +261,16 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>  	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
>  	 PHYS_PFN_OFFSET)
>  
> +#define __pa_symbol_nodebug(x)	((x) - (unsigned long)KERNEL_START)

I don't think I got this one quite right, but I also assume that won't
be the only problem with this patch series.
-- 
Florian
