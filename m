From: joe@perches.com (Joe Perches)
Date: Tue, 15 Nov 2011 18:00:46 -0800
Subject: [PATCH 3/4] mmc: Logging neatening
In-Reply-To: <CAKYAXd8fki1HfFRuRyi4_HNLK6aiFM5NAbyKApgbGaaR=VOTEg@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
 <d2c1a76fea1844ae7ac3e7e17183fb39df19178e.1321398814.git.joe@perches.com>
 <CAKYAXd8_mDF68PnEnpuZZQ+O8-QmrfRpP4jv+SpHDx1juTxFGQ@mail.gmail.com>
 <1321408236.9189.3.camel@Joe-Laptop>
 <CAKYAXd8fki1HfFRuRyi4_HNLK6aiFM5NAbyKApgbGaaR=VOTEg@mail.gmail.com>
Message-ID: <1321408846.9189.5.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 10:55 +0900, NamJae Jeon wrote:
> 2011/11/16 Joe Perches <joe@perches.com>:
> > On Wed, 2011-11-16 at 10:48 +0900, NamJae Jeon wrote:
> >
> > [123K of untrimmed reply]
> >
> > If you wrote something, I didn't find it.
> >
> 
> > -       dev_info(&pdev->dev, "DW MMC controller at irq %d, "
> > -                "%d bit host data width, "
> > -                "%u deep fifo\n",
> > +       dev_info(&pdev->dev,
> > +       "DW MMC controller at irq %d, %d bit host data width, %u deep fifo\n",
> >                 irq, width, fifo_size);
> 
> I think that tab is needed this "DW MMC controller at irq ...." ?

Argument alignment isn't always the right thing.

Very long formats should not necessarily be aligned
at the open parenthesis.  It helps to determine
when the format string or the dmesg output line length
is too long.
