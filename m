From: chunkeey@gmail.com (Christian Lamparter)
Date: Thu, 12 Apr 2018 21:05:59 +0200
Subject: [PATCH] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <CACRpkdacDjzF=CR59by8Zd44wJD12Sr5FSTd=Ph_eSH2QYZudA@mail.gmail.com>
References: <20180328180705.29147-1-chunkeey@gmail.com>
 <CACRpkdacDjzF=CR59by8Zd44wJD12Sr5FSTd=Ph_eSH2QYZudA@mail.gmail.com>
Message-ID: <3015969.TLpigVpPJ0@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Donnerstag, 12. April 2018 14:48:56 CEST Linus Walleij wrote:
> On Wed, Mar 28, 2018 at 8:07 PM, Christian Lamparter <chunkeey@gmail.com> wrote:
> 
> > -       ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
> > -       if (ret) {
> > -               dev_err(pctrl->dev, "Failed to add pin range\n");
> > -               gpiochip_remove(&pctrl->chip);
> > -               return ret;
> > -       }
> 
> If you instead of deleteing this, just wrap it inside
> something like:
> 
> if (!of_property_read_bool(np, "gpio-ranges") {
>   (...)
> }
> 
> You will stay compatible with elder device trees, solving Bj?rns
> issue. You will only be adding hogs to newer device trees with
> the ranges defined anyway.
> 
> Be genereous with comments in the code if you choose this
> approach so everyone realize what is going on.
Thank you for your insightful advice. I just sent out v4 which
goes the of_property_read_bool route. Let's wait and see what
kbuilt-bot has to say.

Best Regards,
Christian
