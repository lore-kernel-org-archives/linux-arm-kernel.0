From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 21 Dec 2017 09:53:42 +0530
Subject: [PATCH v2] ARM: NOMMU: Setup VBAR/Hivecs for secondaries cores
In-Reply-To: <1513694293-5441-1-git-send-email-vladimir.murzin@arm.com>
References: <1513694293-5441-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20171221042342.GA5700@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 19, 2017 at 02:38:13PM +0000, Vladimir Murzin wrote:
> With switch to dynamic exception base address setting, VBAR/Hivecs
> set only for boot CPU, but secondaries stay unaware of that. That
> might lead to weird effects when trying up to bring up secondaries.
> 
> Fixes: ad475117d201 ("ARM: 8649/2: nommu: remove Hivecs configuration is asm")
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

> +#ifndef CONFIG_MMU
> +	setup_vectors_base();
> +#endif

i would have preferred instead,

        if (!IS_ENABLED(CONFIG_MMU))
                setup_vectors_base();

either way,

Acked-by: afzal mohammed <afzal.mohd.ma@gmail.com>

afzal
