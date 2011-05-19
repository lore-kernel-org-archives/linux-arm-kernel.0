From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 19 May 2011 19:37:10 +0200
Subject: [PATCH v6 8/8] MTD: physmap: let set_vpp() pass a
	platform_device instead of a map_info
In-Reply-To: <1305803858.2630.67.camel@localhost>
References: <1305637877-24436-1-git-send-email-marc.zyngier@arm.com>
	<1305637877-24436-9-git-send-email-marc.zyngier@arm.com>
	<1305803858.2630.67.camel@localhost>
Message-ID: <20110519173710.GR15292@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:17 Thu 19 May     , Artem Bityutskiy wrote:
> On Tue, 2011-05-17 at 14:11 +0100, Marc Zyngier wrote:
> > The set_vpp() method provided by physmap passes a map_info back to
> > the platform code, which has little relevance as far as the platform
> > is concerned (this parameter is completely unused).
> > 
> > Instead, pass the platform_device, which can be used in the pismo
> > driver to retrieve some important information in a nicer way, instead
> > of the hack that was in place.
> > 
> > The empty set_vpp function in board-at572d940hf_ek.c is left untouched,
> > as the board/SoC is scheduled for removal.
> > 
> > Cc: Andrew Victor <linux@maxim.org.za>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Philipp Zabel <philipp.zabel@gmail.com>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Acked-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
