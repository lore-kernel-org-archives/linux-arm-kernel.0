From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 01 Apr 2013 17:11:34 -0700 (PDT)
Subject: [PATCH 2/3 v2] ARM: shmobile: r8a7778: add
 r8a7778_init_irq_extpin()
In-Reply-To: <51598121.9010005@cogentembedded.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87d2uf56kt.wl%kuninori.morimoto.gx@renesas.com>
 <51598121.9010005@cogentembedded.com>
Message-ID: <871uat7pw1.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> > +static struct resource irqpin_resources[] = {
> > +	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
> > +	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
> > +	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
> > +	DEFINE_RES_MEM(0xfe780044, 4), /* INTMSK0 */
> > +	DEFINE_RES_MEM(0xfe780064, 4), /* INTMSKCLR0 */
> 
>     Hm, why this can't be passed as a single large memory resource?

see
${LINUX}/drivers/irqchip/irq-renesas-intc-irqpin.c :: intc_irqpin_probe()


Best regards
---
Kuninori Morimoto
