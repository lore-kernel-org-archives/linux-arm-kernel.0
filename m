From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 1 Dec 2009 05:54:59 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
	<cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
Message-ID: <20091201045459.GE18841@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:36 Mon 30 Nov     , Andrew Victor wrote:
> hi Patrick,
> 
> > This patch update the at91_eth_data to handle the usage of PA10 and PA11
> > for EMAC's EXT2 and EXT3 signals.
> 
> > @@ -83,6 +83,7 @@ struct at91_eth_data {
> > ? ? ? ?u32 ? ? ? ? ? ? phy_mask;
> > ? ? ? ?u8 ? ? ? ? ? ? ?phy_irq_pin; ? ?/* PHY IRQ */
> > ? ? ? ?u8 ? ? ? ? ? ? ?is_rmii; ? ? ? ?/* using RMII interface? */
> > + ? ? ? u8 ? ? ? ? ? ? ?use_twi_pins; ? /* ETX2-ETX3 on PA23-PA24 */
> > ?};
> 
> The "at91_eth_data" structure is used on all AT91 processors with a
> MACB peripheral (AT572D940HF, CAP9, 9620, 9263).
> So this isn't really a nice cross-platform change.
I agree 'use_twi_pins' is not the best name maybe alternate_pins or routing
will be better to describe it and will be generic enouch to match all soc

Best Regards,
J.
