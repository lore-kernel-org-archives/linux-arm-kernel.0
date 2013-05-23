From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 May 2013 10:23:43 +0200
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <201305221608.10759.arnd@arndb.de>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdYHiwbGonH80aJfHxP6F+hLb+_KdCr_g5ae1Yr-v=WcxA@mail.gmail.com>
 <201305221608.10759.arnd@arndb.de>
Message-ID: <CACRpkdacteTbFkOQ9w3LQCwN+RDviK04j77itz7uyTiY56+nCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 4:08 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 22 May 2013, Linus Walleij wrote:
>> > diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
>> > index b4d4547..8421537 100644
>> > --- a/drivers/regulator/ab8500-ext.c
>> > +++ b/drivers/regulator/ab8500-ext.c
>> > @@ -334,6 +334,12 @@ int ab8500_ext_regulator_init(struct platform_device *pdev)
>> >                 return -EINVAL;
>> >         }
>> >
>> > +       /* have any external regulators been specified? */
>> > +       if (pdata->num_ext_regulator == 0) {
>> > +               dev_warn(&pdev->dev, "Not using external regulators\n");
>> > +               return 0;
>> > +       }
>>
>> dev_warn() is really when we warn about something really nasty, worse
>> than dev_err(). It seems dev_info() is more apropriate.
>
> Are you confusing it with dev_crit()?
>
> This is how the levels are defined, and "warning" is less urgent than "error":

Yeah :-/

But I still think this should be just dev_info().

No big deal though.

Yours,
Linus Walleij
