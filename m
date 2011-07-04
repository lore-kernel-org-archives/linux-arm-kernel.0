From: christian.glindkamp@taskit.de (Christian Glindkamp)
Date: Mon, 4 Jul 2011 11:19:31 +0200
Subject: [PATCH 2/8] at91: factorize at91 interrupts init to soc
In-Reply-To: <1309502682-16897-2-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110704091931.GB5509@taskit.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-07-01 08:44, Jean-Christophe PLAGNIOL-VILLARD wrote:
> they are the same except the default priority
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> ---
>  arch/arm/mach-at91/board-gsia18s.c      |    5 -----
>  arch/arm/mach-at91/board-pcontrol-g20.c |    7 -------
>  arch/arm/mach-at91/board-stamp9g20.c    |    6 ------

Aren't you breaking these boards? You remove their init_irq function
without updating the machine structure.
