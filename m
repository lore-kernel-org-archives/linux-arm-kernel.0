From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 10:25:06 +0200
Subject: [PATCH 03/16] pinctrl: samsung: Detect and handle unsupported
 configuration types
In-Reply-To: <CACRpkda8mBsetmkWSfed0VpGA_Aw4vNUSGZcTx=bY8LDRzxFdA@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-4-git-send-email-t.figa@samsung.com>
 <CACRpkda8mBsetmkWSfed0VpGA_Aw4vNUSGZcTx=bY8LDRzxFdA@mail.gmail.com>
Message-ID: <2300237.byLt0lYsM2@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:37:42 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > This patch modifies the pinctrl-samsung driver to detect when width of
> > a
> > bit field is set to zero (which means that such configuraton type is
> > not
> > supported) and return an error instead of trying to modify an
> > inexistent
> > register.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > ---
> > 
> >  drivers/pinctrl/pinctrl-samsung.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-samsung.c
> > b/drivers/pinctrl/pinctrl-samsung.c index dd108a9..c660fa5 100644
> > --- a/drivers/pinctrl/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/pinctrl-samsung.c
> > @@ -391,6 +391,9 @@ static int samsung_pinconf_rw(struct pinctrl_dev
> > *pctldev, unsigned int pin,> 
> >                 return -EINVAL;
> >         
> >         }
> > 
> > +       if (!width)
> > +               return -EINVAL;
> > +
> 
> Can this patch be applied in isolation from the others?

Yes, I don't see any problem here.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
