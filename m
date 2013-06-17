From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 20:52:56 +0200
Subject: [RFC PATCH 08/11] dmaengine: PL08x: Add cyclic transfer support
In-Reply-To: <CACRpkdbW3GW4-UL2Qhv+3Vcpv84d3sT+-7t+d3ZPJ4_0KEkNmg@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-9-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdbW3GW4-UL2Qhv+3Vcpv84d3sT+-7t+d3ZPJ4_0KEkNmg@mail.gmail.com>
Message-ID: <1469066.0V8nhZHHN8@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 15:57:38 Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > From: Alban Bedel <alban.bedel@avionic-design.de>
> > 
> > Many audio interface drivers require support of cyclic transfers to
> > work correctly, for example Samsung ASoC DMA driver. This patch adds
> > support for cyclic transfers to the amba-pl08x driver.
> > 
> > Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Nice! This is useful for others as well.
> 
> > @@ -198,6 +199,8 @@ struct pl08x_txd {
> > 
> >          */
> >         
> >         u32 ccfg;
> >         bool done;
> > 
> > +
> > +       bool cyclic;
> > 
> >  };
> 
> You can never have enough whitespace right?
> 
> >  /**
> > 
> > @@ -561,9 +564,9 @@ static u32 pl08x_getbytes_chan(struct
> > pl08x_dma_chan *plchan)> 
> >                         bytes +=
> >                         get_bytes_in_cctl(llis_va[index].cctl);
> >                 
> >                 /*
> > 
> > -                * A LLI pointer of 0 terminates the LLI list
> > ++               * A LLI pointer going backward terminates the LLI
> > list
> 
> ++? Really?
> 
> This looks like a merge leftover being merged in.

I think it's a copy/paste error when applying some hunks of the original 
patch manually.

> > -               if (!llis_va[index].lli)
> > +               if (llis_va[index].lli <= clli)
> 
> This was clever.
> 
> The rest of the code looks nice.

OK. I will fix the issues you mentioned in next version.

Best regards,
Tomasz
