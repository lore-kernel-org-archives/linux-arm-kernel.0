From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 May 2012 18:01:12 +0200
Subject: [PATCH v9 3/3] MTD: at91: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <4FC3389C.5050303@atmel.com>
References: <1338038677-6752-1-git-send-email-josh.wu@atmel.com>
 <1338038677-6752-4-git-send-email-josh.wu@atmel.com>
 <20120528065822.GL3377@game.jcrosoft.org>
 <4FC3389C.5050303@atmel.com>
Message-ID: <20120529160112.GT3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+
> >>+static void __iomem *pmecc_get_index_of(struct atmel_nand_host *host)
> >this is a __dev_init function plese check the other too
> >
> >btw you need to use __dev_init and not __init
> 
> Here I use pmecc_get_index_of() function to get a lookup table base
> which is in ROM.
> I'm not clear about how should I need __dev_init here. Can you give
> more information?

it is the section where the function is going to be stored

pmecc_get_index_of is use at probe time so it's __devinit section

as it's supposed to be for the probe function too

Best Regards,
J.
