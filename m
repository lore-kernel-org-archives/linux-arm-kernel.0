From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 3 Sep 2010 18:41:58 +0200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <1282575669-24501-1-git-send-email-nicolas.ferre@atmel.com>
References: <20091107122002.1ecf6483@hskinnemoen-d830>
	<1282575669-24501-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20100903164158.GH17702@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:01 Mon 23 Aug     , Nicolas Ferre wrote:
> Add a simple gpio_is_valid() function to replace
> the standard one. It introduces the __HAVE_ARCH_GPIO_IS_VALID
> macro to overload the generic code.
> As an implementation example, it takes into account the AT91
> pio numbering to check if a proper value is used.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Hi all,
> 
> I come back on this thread as I would like to implement the gpio_is_valid()
> function for AT91. I have based this piece of code on comments from Ben and
> Haavard and chose the  __HAVE_ARCH_* macro definition as it seems wide spread
> in kernel code.
> Please make comments and if it is ok for you, eventually accept for merging...
> 
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

specially when the drivers are share between different arch such as here avr32
and arm
but also for renesas between sh and arm and ST between SH and ST200

the representation of an invalid gpio could differ and invalade it dito

Best Regards,
J.
