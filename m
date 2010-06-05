From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 5 Jun 2010 15:59:56 +0800
Subject: [PATCH 1/3] MTD/pxa: patch for error return value method of
	pxa2xx-flash.c
In-Reply-To: <AANLkTilydl5oKETCC69C_QY6xJa3mIXve097JU6qevfp@mail.gmail.com>
References: <4C09F15E.9020408@gmail.com>
	<AANLkTinLfGD-x-861sFK9r2zW5aEZvyXIB4PFKJl8NDZ@mail.gmail.com>
	<AANLkTikJiPjl3LKVqgqtlK2YEePXDf7K6EdOlUE4uzBb@mail.gmail.com>
	<AANLkTilydl5oKETCC69C_QY6xJa3mIXve097JU6qevfp@mail.gmail.com>
Message-ID: <AANLkTile8PqagLri8n1Y0Xn03e8STx7XQODUx83woYNE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 5, 2010 at 3:53 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> Hi Eric,
>
> This following piece of code:
>
> ? ? ? ?if (!info->map.virt) {
> ? ? ? ? ? ? ? ?printk(KERN_WARNING "Failed to ioremap %s\n",
> ? ? ? ? ? ? ? ? ? ? ? info->map.name);
> ? ? ? ? ? ? ? ?ret = -ENOMEM;
> ? ? ? ? ? ? ? ?goto fail2;
> ? ? ? ?}
>
> Shouldn't ?the 'KERN_ERR' in stead of the 'KERN_WARNING '?
> Because the ?'info->map.virt == NULL' can arouse the serious crash.
>

The thing is you need to figure out if it is mandatory because we
have another info->map.cached just in case. Disaster is both can
not be mapped.
