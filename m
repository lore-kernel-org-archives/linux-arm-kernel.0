From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 7 Jul 2014 21:55:56 +0200
Subject: [PATCH 3/5] ARM: at91/dt: sama5d3: define mpddr clock and ramc
 clocks
In-Reply-To: <20140707183236.GF9558@ns203013.ovh.net>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404746355-19988-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20140707183236.GF9558@ns203013.ovh.net>
Message-ID: <20140707195556.GI3113@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2014 at 20:32:36 +0200, Jean-Christophe PLAGNIOL-VILLARD wrote :
> > -				compatible = "atmel,at91sam9g45-ddramc";
> > +				compatible = "atmel,sama5d3-mpddramc", "atmel,at91sam9g45-ddramc";
> the sama5 ddr controler is not back compitble with 9g45 one the compatible is
> wrong

Keeping atmel,at91sam9g45-ddramc allows to reuse the old code for the
iomap needed for the PM code without adding a new compatible in the
ramc_ids[] array.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
