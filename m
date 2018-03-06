From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Mar 2018 13:56:42 -0300
Subject: Regulator regression in next-20180305
In-Reply-To: <20180306163035.GE13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
Message-ID: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e685f8b94acf..2c5b20a97f51 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
>  {
>         int i;
>
> -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
>                 mutex_lock_nested(&rdev->mutex, i);

With this change the log is a bit different, but still get a kernel hang:
https://pastebin.com/eF08TnuT

Thanks
