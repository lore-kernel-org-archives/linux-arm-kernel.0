From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 29 Jul 2013 09:19:16 +0000 (UTC)
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1307290917160.30864@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, 

On Mon, 29 Jul 2013, Linus Walleij wrote:

> If we revert these three patches:
> 
> commit 949eb1a4d29dc75e0b5b16b03747886b52ecf854
> "gpio/omap: fix build error when OF_GPIO is not defined."
> commit b4419e1a15905191661ffe75ba2f9e649f5d565e
> "gpio/omap: auto request GPIO as input if used as IRQ via DT"
> commit 0e970cec05635adbe7b686063e2548a8e4afb8f4
> "gpio/omap: don't create an IRQ mapping for every GPIO on DT"
> 
> Does the OMAP1 boot again after this?

Yep, it boots fine with those three patches reverted:

http://www.pwsan.com/omap/testlogs/bisect_5912osk_boot_fail_v3.11-rc3/20130729030748/boot/5912osk/5912osk_log.txt


- Paul
