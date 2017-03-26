From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sun, 26 Mar 2017 18:05:55 +0200
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170326160126.nwboar7mwztwxtgp@kozik-lap>
References: <20170325162654.3827-1-krzk@kernel.org>
 <CANc+2y4+1-oH50Y1tmTtOJ11snvi=FwNkjUbOE5ANPyNuzXOqg@mail.gmail.com>
 <20170326160126.nwboar7mwztwxtgp@kozik-lap>
Message-ID: <6597290.C3JGqjKOeS@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 26. M?rz 2017, 18:01:26 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> > > +       if (slen < EXYNOS_RNG_SEED_SIZE) {
> > > +               dev_warn(rng->dev, "Seed too short (only %u bytes)\n",
> > > slen); +               return -EINVAL;
> > > +       }
> > 
> > Will it be helpful to print the required seed size?
> 
> It is in /proc/crypto... It is not a problem to print it but isn't that
> redundant?

You also get the information from crypto_user.

See [1] for a user space API.

[1] https://github.com/smuellerDD/libkcapi/commit/
f856e8c655b7e5c53f59ef8c5754ad59b196df08


Ciao
Stephan
