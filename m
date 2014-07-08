From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Jul 2014 09:51:06 +0200
Subject: [PATCH 3/5] ARM: at91/dt: sama5d3: define mpddr clock and ramc
 clocks
In-Reply-To: <20140707195556.GI3113@piout.net>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404746355-19988-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20140707183236.GF9558@ns203013.ovh.net>
 <20140707195556.GI3113@piout.net>
Message-ID: <20140708075105.GI13423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 07, 2014 at 09:55:56PM +0200, Alexandre Belloni wrote:
> On 07/07/2014 at 20:32:36 +0200, Jean-Christophe PLAGNIOL-VILLARD wrote :
> > > -				compatible = "atmel,at91sam9g45-ddramc";
> > > +				compatible = "atmel,sama5d3-mpddramc", "atmel,at91sam9g45-ddramc";
> > the sama5 ddr controler is not back compitble with 9g45 one the compatible is
> > wrong
> 
> Keeping atmel,at91sam9g45-ddramc allows to reuse the old code for the
> iomap needed for the PM code without adding a new compatible in the
> ramc_ids[] array.

That looks like a pretty bad argument :)

If the two devices are not alike, they should have a different
compatible, it's as simple as that, and Linux should just deal with
it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/2c912274/attachment.sig>
