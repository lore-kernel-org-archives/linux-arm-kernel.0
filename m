From: carlo@caione.org (Carlo Caione)
Date: Wed, 22 Oct 2014 11:52:40 +0200
Subject: [PATCH v3 1/3] ARM: meson: reset: Add reset controller for
 MesonX SoCs
In-Reply-To: <1413819611.3107.6.camel@pengutronix.de>
References: <1413803985-8363-1-git-send-email-carlo@caione.org>
 <1413803985-8363-2-git-send-email-carlo@caione.org>
 <1413819611.3107.6.camel@pengutronix.de>
Message-ID: <20141022095240.GA22342@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, ott 20, 2014 at 05:40:11 +0200, Philipp Zabel wrote:
> Am Montag, den 20.10.2014, 13:19 +0200 schrieb Carlo Caione:
> > Hi Philipp,
> > from the documentation and the sources I have, it seems that in the register
> > together with the bits for resetting the ICs there are also bits for turning
> > the ICs on and off. I really wanted to avoid create a new of_xlate function
> > just to map the reset IDs to the correct bit in the register so I left the
> > nr_resets to BITS_PER_LONG and I'm using the default of_xlate.
> > This way I can also avoid to use obscure reset IDs to be remapped when I can
> > use directly the bit number in the register as reset ID.
> 
> I'm fine with reusing of_reset_simple_xlate and using the bit offsets as
> reset control number. Do you already know what abstraction you'll choose
> for the IC enable bits? (Are those clock gates, or maybe power domains?)
> Hopefully the documentation you obtained will help to decide.

Those are clock gates actually. Arnd suggested to add a driver for the
entire block (resets and clock gates) so probably I need to dig deeper
in the CCF.

-- 
Carlo Caione
