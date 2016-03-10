From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 10 Mar 2016 05:34:12 +0100
Subject: [PATCH 4/6] parisc: rtc: provide rtc_class_ops directly
In-Reply-To: <1456851608-3374907-5-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-5-git-send-email-arnd@arndb.de>
Message-ID: <20160310043412.GC9868@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2016 at 18:00:00 +0100, Arnd Bergmann wrote :
> -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> +					     &rtc_generic_ops,
> +					     sizeof(rtc_generic_ops));
> +
> +

spurious blank line

>  	return PTR_ERR_OR_ZERO(pdev);
>  }
>  device_initcall(rtc_init);
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
