From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 May 2012 11:31:25 +0200
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1337160353.24809.26.camel@sauron.fi.intel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
 <1337160353.24809.26.camel@sauron.fi.intel.com>
Message-ID: <20403.29677.517067.528042@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Artem Bityutskiy writes:
> On Tue, 2012-05-15 at 22:47 +0800, Josh Wu wrote:
> > +	while (!(pmerrloc_readl(host->pmerrloc_base, ELISR)
> > +		 & PMERRLOC_CALC_DONE))
> > +		cpu_relax();
> 
> How about some kind of time-out in something goes wrong?
> 
> > +		dev_warn(host->dev, "Only 2048 page size is currently " \
> > +			"supported for PMECC, rolling back to Software ECC\n");
> 
> Why do you use backslashes?
> 
message text should not be split across lines anyway to ease grepping
for the message.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
