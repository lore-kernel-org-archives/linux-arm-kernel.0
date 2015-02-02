From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Feb 2015 15:58:49 +0100
Subject: [PATCH v2] mmc: moxart: fix probe logic
In-Reply-To: <CACmBeS0RGJUzqztQLZtHyTYgCd=jpAoYYk-roH7_VLbfy-+ftw@mail.gmail.com>
References: <8340872.32GezMfzR1@wuerfel> <1862200.Pj3heKAtuk@wuerfel>
 <CACmBeS0RGJUzqztQLZtHyTYgCd=jpAoYYk-roH7_VLbfy-+ftw@mail.gmail.com>
Message-ID: <4754899.RDUhFfxBSW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 February 2015 11:52:44 Jonas Jensen wrote:
> 
> On 29 January 2015 at 23:06, Arnd Bergmann <arnd@arndb.de> wrote:
> > Jonas Jensen wanted to submit a patch for these, but apparently
> > forgot about it. I stumbled over this symptom first:
> 
> Sorry about this, I remember thinking about the changes but only made
> a mental note (which was lost over time). I was sidetracked with other
> changes and work.
> 
> 
> > @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
> >                 goto out;
> >         }
> >
> > -       clk = of_clk_get(node, 0);
> > -       if (IS_ERR(clk)) {
> > +       host->clk = of_clk_get(node, 0);
> 
> host->clk is a NULL dereference at this point in probe() (log below).
> 
> I moved the single line "host = mmc_priv(mmc);" to happen just before,
> and everything is working normally again.

Thanks a lot for testing, and finding the second embarrassing bug
in my patch!

Can you forward the patch you successfully tested with your
Signed-off-by?

	Arnd
