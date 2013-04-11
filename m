From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 11 Apr 2013 23:33:31 +0200
Subject: [PATCH] cpufreq: dbx500: Round to closest available freq
In-Reply-To: <CACRpkdb75wPjXEYdkqE6BOCsuFA_ZBc6GAz1m-5vHWSrSGKyUA@mail.gmail.com>
References: <1365599175-22361-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb75wPjXEYdkqE6BOCsuFA_ZBc6GAz1m-5vHWSrSGKyUA@mail.gmail.com>
Message-ID: <1512269.3ZuqNVLx3s@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 11, 2013 10:33:07 PM Linus Walleij wrote:
> On Wed, Apr 10, 2013 at 3:06 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> 
> > From: Mats Fagerstrom <mats.fagerstrom@stericsson.com>
> >
> > When reading the cpu speed, round it to the closest available
> > frequency from the table.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Mats Fagerstrom <mats.fagerstrom@stericsson.com>
> 
> (...)
> > +       /* The value is rounded to closest frequency in the defined table. */
> > +       while (freq_table[i + 1].frequency != CPUFREQ_TABLE_END) {
> > +               if (freq < freq_table[i].frequency +
> > +                  (freq_table[i + 1].frequency - freq_table[i].frequency) / 2)
> >                         return freq_table[i].frequency;
> 
> Oh that works, clever.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
