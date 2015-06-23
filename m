From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Jun 2015 22:39:40 +0200
Subject: [PATCH] ARM: ep93xx: toss the device ID into the entropy pool
In-Reply-To: <1434638859-27381-1-git-send-email-linus.walleij@linaro.org>
References: <1434638859-27381-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2274537.5rEXu4xPQS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 June 2015 16:47:39 Linus Walleij wrote:
> @@ -862,6 +863,12 @@ static const char __init *ep93xx_get_soc_id(void)
>         if (id != id2)
>                 return "invalid";
>  
> +       /* Toss the unique ID into the entropy pool */
> +       add_device_randomness(&id2, 4);
> +       add_device_randomness(&id3, 4);
> +       add_device_randomness(&id4, 4);
> +       add_device_randomness(&id5, 4);
> +
> 

A stupid question from someone who does not understand computer
security: Is there any concern about being able to identify a
particular machine based on the random numbers generated at
runtime afterwards?

	Arnd
