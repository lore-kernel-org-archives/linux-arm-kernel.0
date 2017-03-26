From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 26 Mar 2017 19:05:48 +0200
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <CANc+2y4xkDs2kQGXKP=8i_v9oYw4dPKTjWs0xFnvOcwDbar47g@mail.gmail.com>
References: <20170325162654.3827-1-krzk@kernel.org>
 <20170326160126.nwboar7mwztwxtgp@kozik-lap>
 <CANc+2y4xkDs2kQGXKP=8i_v9oYw4dPKTjWs0xFnvOcwDbar47g@mail.gmail.com>
Message-ID: <1535446.zHpTqe8jba@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 26. M?rz 2017, 18:46:02 CEST schrieb PrasannaKumar Muralidharan:

Hi 	Krzysztof,

> >> > +       if (slen < EXYNOS_RNG_SEED_SIZE) {
> >> > +               dev_warn(rng->dev, "Seed too short (only %u bytes)\n",
> >> > slen); +               return -EINVAL;
> >> > +       }
> >> 
> >> Will it be helpful to print the required seed size?
> > 
> > It is in /proc/crypto... It is not a problem to print it but isn't that
> > redundant?
> 
> Not necessary if it is already available.

Maybe the dev_warn should be removed. Note, unprivileged user space can 
trigger this warning by simply invoking the seeding operation over and over 
again with an insufficient seed size. This would clutter the log.

Ciao
Stephan
