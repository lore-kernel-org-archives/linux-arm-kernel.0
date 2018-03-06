From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Mar 2018 09:18:19 -0800
Subject: Regulator regression in next-20180305
In-Reply-To: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
Message-ID: <20180306171819.GF5796@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fabio Estevam <festevam@gmail.com> [180306 16:57]:
> Hi Mark,
> 
> On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:
> 
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index e685f8b94acf..2c5b20a97f51 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
> >  {
> >         int i;
> >
> > -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> > +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
> >                 mutex_lock_nested(&rdev->mutex, i);
> 
> With this change the log is a bit different, but still get a kernel hang:
> https://pastebin.com/eF08TnuT

That patch does not seem to change anything for me. The errors
I posted yesterday for mmc0 only happen on duovero, other omap
variants just fail silently with no cards showing.

Regards,

Tony
