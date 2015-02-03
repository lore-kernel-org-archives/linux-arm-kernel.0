From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 10:06:51 +0100
Subject: [PATCH v3] mmc: moxart: fix probe logic
In-Reply-To: <CAPDyKFoppJBHx4nio111GM9RPv8pkfm4yZg2+AedLjnSZhmFsg@mail.gmail.com>
References: <4754899.RDUhFfxBSW@wuerfel>
 <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com>
 <CAPDyKFoppJBHx4nio111GM9RPv8pkfm4yZg2+AedLjnSZhmFsg@mail.gmail.com>
Message-ID: <11355014.PH1MhDAcRs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 09:02:22 Ulf Hansson wrote:
> > @@ -586,10 +588,11 @@ static int moxart_probe(struct platform_device *pdev)
> >                 goto out;
> >         }
> >
> > -       clk = of_clk_get(node, 0);
> 
> This code would be simpler using devm_clk_get(), since then error
> wouldn't be needed.
> 
> Any reason to why you don't want to use that?

You are absolutely right, and that would have avoided both of the bugs
I introduced.

	Arnd
