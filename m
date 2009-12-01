From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 1 Dec 2009 16:59:08 +0100
Subject: [PATCH 1/3] AT91: update at91_eth_data for ETX2-3 on PA10-11
In-Reply-To: <aa8983610912010058j738df89fyd75e9e75973e94ed@mail.gmail.com>
References: <20091129234917.GB18841@game.jcrosoft.org>
	<1259574486-13391-1-git-send-email-derkling@gmail.com>
	<1259574486-13391-2-git-send-email-derkling@gmail.com>
	<cd73a99e0911301236pd18a382o6faa04c15b3bf9c@mail.gmail.com>
	<aa8983610912010058j738df89fyd75e9e75973e94ed@mail.gmail.com>
Message-ID: <20091201155908.GF18841@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:58 Tue 01 Dec     , Patrick Bellasi wrote:
> On Mon, Nov 30, 2009 at 9:36 PM, Andrew Victor <avictor.za@gmail.com> wrote:
> > hi Patrick,
> >
> >> This patch update the at91_eth_data to handle the usage of PA10 and PA11
> >> for EMAC's EXT2 and EXT3 signals.
> >
> >> @@ -83,6 +83,7 @@ struct at91_eth_data {
> >> ? ? ? ?u32 ? ? ? ? ? ? phy_mask;
> >> ? ? ? ?u8 ? ? ? ? ? ? ?phy_irq_pin; ? ?/* PHY IRQ */
> >> ? ? ? ?u8 ? ? ? ? ? ? ?is_rmii; ? ? ? ?/* using RMII interface? */
> >> + ? ? ? u8 ? ? ? ? ? ? ?use_twi_pins; ? /* ETX2-ETX3 on PA23-PA24 */
> >> ?};
> >
> > The "at91_eth_data" structure is used on all AT91 processors with a
> > MACB peripheral (AT572D940HF, CAP9, 9620, 9263).
> > So this isn't really a nice cross-platform change.
> 
> That's true: different chips use different GPIO multiplexing.
> However, we should provide an "extensible" support for board which
> don't use the reference design routing.
> 
> Personally I don't like the solution proposed by Jean-Christophe to
> use a name which is "generic enough to match all soc": indeed that
> solution is not well self-describing.
> 
> I noticed that the board.h already use ifdefs to customise data
> structures for different SoC. This could be a valuable solution to
> support SoC specific data too.
> Thus, I personally prefer the solution showed thereafter, where we have:
> 1. explicit definition of what SoC support that configuration parameter
> 2. use a self-explaining name which provide a more readable code
> within the SoC specific code that use the data structure (e.g.
> at91sam9260_devices.c)
> 3. the same approach could be extended to others data structure,
> whenever it is necessary, without triggering a new discussion on ML
> about what could be "the better name for..."
except here the TWI description is incorrect as you do not care about the twi
when you configured the MACB as I can want to use the two pin for something
else than I2C. So we need to describe want we want to do about the MACB and
not a possible alternated functionnality.

Best Regards,
J.
