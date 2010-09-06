From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 00:49:01 +0200
Subject: [PATCH 01/74] ST SPEAr: Padmux code Updated
In-Reply-To: <90f361f70296c1762fae29a8d00d37c51b53cee2.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<90f361f70296c1762fae29a8d00d37c51b53cee2.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906224901.GC8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
> -void spear300_pmx_init(void)
> -{
> -	spear_pmx_init(&pmx_driver, SPEAR300_SOC_CONFIG_BASE,
> +	/* pmx initialization */
> +	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE,
>  			SPEAR300_SOC_CONFIG_SIZE);
> +	if (pmx_driver.base) {
> +		ret = pmx_register(&pmx_driver);
> +		if (ret)
> +			printk(KERN_ERR "padmux: registeration failed. err no"
> +					": %d\n", ret);
> +		iounmap(pmx_driver.base);
why unmap it?

Best Regards,
J.
