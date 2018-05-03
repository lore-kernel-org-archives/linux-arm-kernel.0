From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 3 May 2018 17:05:34 +0200
Subject: [PATCH 06/17] irqchip/irq-mvebu-icu: switch to regmap
In-Reply-To: <20180430155352.1b24d1d8@windsurf>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-7-miquel.raynal@bootlin.com>
 <20180430155352.1b24d1d8@windsurf>
Message-ID: <20180503170534.6b42510e@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Gregory,

On Mon, 30 Apr 2018 15:53:52 +0200, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Sat, 21 Apr 2018 15:55:26 +0200, Miquel Raynal wrote:
> > The ICU DT nodes have now the 'syscon' compatible, we can switch to  
> 
> have now -> now have
> 
> > regmap before splitting the code to support multiple platform devices to
> > be probed (one for the ICU, one per interrupt group).
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> As I explained in the review of PATCH 03/17, I think we could simply
> create the regmap in the ->probe() of the parent device, instead of
> using the "syscon" property, which is mainly useful when there is no
> parent device.

This is a much better idea than adding the 'syscon' compatible. I will
work on it.

> 
> The rest of the conversion to regmap looks good otherwise.
> 
> Best regards,
> 
> Thomas

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
