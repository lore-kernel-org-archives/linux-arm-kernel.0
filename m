From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 22 May 2013 15:32:36 +0200
Subject: [PATCH v2 6/6] pinctrl: exynos: Handle suspend/resume of GPIO EINT
 registers
In-Reply-To: <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <4536937.hnhaYZLnaG@amdc1227>
 <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
Message-ID: <4391865.a7p9jbyZ7B@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 of May 2013 21:46:35 Doug Anderson wrote:
> Tomasz,
> 
> On Tue, May 21, 2013 at 10:05 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> >         return 0;
> > 
> > +
> > +err_domains:
> > +       bank = d->ctrl->pin_banks;
> > +       for (undo = 0; undo < i; ++undo) {
> 
> ++bank is missing, I think.  This will free the same bank many times.

Shit, this is what happens when you post patches so late and in a hurry. Will 
send something sane in a while.

> optional: could also avoid extra 'undo' variable and remove in reverse
> order by changing i to signed and counting down to 0.

Sure.

Best regards,
Tomasz

> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
