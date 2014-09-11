From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 11 Sep 2014 17:38:54 +0200
Subject: [PATCH] mtd: nand: atmel_nand: retrieve NFC clock
In-Reply-To: <20140911152029.GA16666@arch>
References: <1410446617-29572-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20140911152029.GA16666@arch>
Message-ID: <20140911173854.73b201e7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Thu, 11 Sep 2014 12:20:30 -0300
Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:

> Hi Alexandre,
> 
> On 11 Sep 04:43 PM, Alexandre Belloni wrote:
> > @@ -2276,6 +2280,16 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	nfc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(nfc->clk)) {
> > +		dev_warn(&pdev->dev, "NFC clock is missing");
> > +		return 0;
> > +	}
> > +
> 
> The binding documentation makes no mention to a clock.

You're right, I didn't update atmel,nand DT binding doc.

> 
> Anyway, with or without the docs I think this patch breaks DT backward
> compatibility.
> 
> Or am I missing something?

Indeed, this block of code should be placed at the end of the probe
function. I'll fix that.

Note that if the clk is missing it just print a warning message and
return 0, so after moving the code, it should not break DT backward
compat ;-).

Best Regards,

Boris
-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
