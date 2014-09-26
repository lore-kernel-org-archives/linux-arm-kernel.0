From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 22:13:31 +0200
Subject: [PATCH v2 1/3] drivers: of: add return value to
 of_reserved_mem_device_init
In-Reply-To: <1410434561-9294-2-git-send-email-m.szyprowski@samsung.com>
References: <1410434561-9294-1-git-send-email-m.szyprowski@samsung.com>
 <1410434561-9294-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201409262213.31848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014, Marek Szyprowski wrote:
> -void of_reserved_mem_device_init(struct device *dev)
> +int of_reserved_mem_device_init(struct device *dev)
>  {
>         struct reserved_mem *rmem;
>         struct device_node *np;
> @@ -260,6 +260,7 @@ void of_reserved_mem_device_init(struct device *dev)
>  
>         rmem->ops->device_init(rmem, dev);
>         dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
> +       return 0;
>  }

This function has two other 'return' statements that now are missing 
a return value for the error case and cause undefined behavior
in the caller.

	Arnd
