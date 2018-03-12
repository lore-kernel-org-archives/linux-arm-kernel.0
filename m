From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 12 Mar 2018 13:05:31 -0400 (EDT)
Subject: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-2-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
 <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
 <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
 <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1803121303350.28583@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2018, Nicolas Pitre wrote:

> On Mon, 12 Mar 2018, Arnd Bergmann wrote:
> 
> > arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
> > No such file
> 
> That is weird. The Makefile has:
> 
> cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)
> 
> $(obj)/xipImage: vmlinux FORCE
>         $(call if_changed,mkxip)
> 
> So the objcopy must succeed at producing vmlinux for deflate_xip_data 
> (where nm is used) to be called.

Correction: vmlinux is a dependency not a product, so it must be there 
for this rule to be executed, and it is input to both objcopy and nm.


Nicolas
