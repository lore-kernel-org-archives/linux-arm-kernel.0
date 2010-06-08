From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 19:23:34 +0800
Subject: [PATCH 2/2] pxa: modify the pxa2xx-ac97 file for pxa168
In-Reply-To: <4C0E21A1.4000909@gmail.com>
References: <4C0E21A1.4000909@gmail.com>
Message-ID: <AANLkTimNwtScfKYVc4qPZFEP6GYklPoHLgr2AE7yquQL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/8 Wan ZongShun <mcuos.com@gmail.com>:
> In order to allow the sharing of the pxa2xx-ac97 driver file with pxa168,
> we have to do a little change to pxa2xx-ac97 file.
>
> All private register addresses were located in mach/include/ac97.h.

This is not the right way to go, as suggested already. I hope the ac97
driver is more self-contained. i.e. having a platform device for:

 - where the registers are mapped from
 - drcmr channel numbers can be encoded within dma resource
 - ac97 register definitions are not exposed everywhere
