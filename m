From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 May 2013 21:46:35 -0700
Subject: [PATCH v2 6/6] pinctrl: exynos: Handle suspend/resume of GPIO
 EINT registers
In-Reply-To: <4536937.hnhaYZLnaG@amdc1227>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <18754346.1REWN52J0K@flatron>
 <CAD=FV=XiWET3Xptfk2CVWMw=xVCE4zUJhJtgXHbhiND12rJGnQ@mail.gmail.com>
 <4536937.hnhaYZLnaG@amdc1227>
Message-ID: <CAD=FV=VYhBP+V6SQt5SkFZszdVxSJ6AZk-C-zx1Di-RZBYhGvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Tue, May 21, 2013 at 10:05 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>         return 0;
> +
> +err_domains:
> +       bank = d->ctrl->pin_banks;
> +       for (undo = 0; undo < i; ++undo) {

++bank is missing, I think.  This will free the same bank many times.

optional: could also avoid extra 'undo' variable and remove in reverse
order by changing i to signed and counting down to 0.

-Doug
