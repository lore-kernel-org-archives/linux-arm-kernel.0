From: ytk.lee@samsung.com (Yongtaek Lee)
Date: Thu, 03 Sep 2015 17:43:29 +0900
Subject: [PATCH] ARM: fix bug which VMALLOC_START is lowwer than
 0xf0000000
In-Reply-To: <1441269272.3102.3.camel@pengutronix.de>
References: <1441269272.3102.3.camel@pengutronix.de>
Message-ID: <1441269809-11688-1-git-send-email-ytk.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, if we go and apply your logic to a 1GB system we should resize the
> vmalloc area to 0 bytes in order to avoid RAM truncation without
> CONFIG_HIGHMEM?

As you already know, CONFIG_HIGHMEM option is necessary if RAM is
more than 1GB. So no need to resize vmalloc area to 0. 

> Sorry, but the only sane options here are to either live with the
> truncation, enable CONFIG_HIGHMEM, or set vmalloc size manually.
> Changing a default value that affects everyone for the benefit of your
> specific use-case isn't a sane option.
