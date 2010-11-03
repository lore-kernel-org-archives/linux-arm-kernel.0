From: sunder.svit@gmail.com (Sundar)
Date: Wed, 3 Nov 2010 19:41:44 +0530
Subject: [PATCH] ARM amba: optional PrimeCell core voltage switch
In-Reply-To: <1288778988-11041-1-git-send-email-linus.walleij@stericsson.com>
References: <1288778988-11041-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTimPH7KHZrTtdGSSno7zz7tH56KCbYjoJibK=WwL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 3, 2010 at 3:39 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
>
> +static int amba_get_enable_vcore(struct amba_device *pcdev)
> +{
> + ? ? ? struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
> + ? ? ? int ret;
> +
> + ? ? ? pcdev->vcore = vcore;
> +
> + ? ? ? if (IS_ERR(vcore)) {
> + ? ? ? ? ? ? ? /* It is OK not to supply a vcore regulator */
> + ? ? ? ? ? ? ? if (PTR_ERR(vcore) == -ENODEV)
> + ? ? ? ? ? ? ? ? ? ? ? return 0;
> + ? ? ? ? ? ? ? return PTR_ERR(vcore);
> + ? ? ? }

If i am right, you corrupt the pcdev->vcore even in an error case.

Cheers!
