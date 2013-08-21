From: xiechao.mail@gmail.com (Chao Xie)
Date: Wed, 21 Aug 2013 11:19:01 +0800
Subject: remove pxa ssp driver???
Message-ID: <CADApbej4bvSW7PVXnor4v3iFMcZ=ZHN9T_ST5-SYFJZM9sakDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi
In arch/arm/plat-pxa, there is a ssp driver named ssp.c.
The ssp driver will probe all the ssp devices one by one, and linked
them into a list.
The driver also provides two APIs pxa_request_pxa() and pxa_ssp_free().

So why we will have ssp.c driver? The only thing the driver will do is
linked all the ssp devices into a list, and then provides APIs to
others to allocate and free the ssp ports.

The ssp connection is defined by board, and it is fixed. So for a
single board, i do not think the port will be allocated or freed
dynamically. Is there any case that will two drivers will share same
port?

If the two APIs are not needed. Then we can remove the driver, and
lets other drivers, for example, spi-pxa.c and sound/soc/pxa/pxa-ssp.c
to directly handle the ssp resources(get irq number, iomap the
register and etc.)
