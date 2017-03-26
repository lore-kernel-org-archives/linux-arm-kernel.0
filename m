From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 26 Mar 2017 21:09:59 +0300
Subject: [PATCH v3 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <1535446.zHpTqe8jba@positron.chronox.de>
References: <20170325162654.3827-1-krzk@kernel.org>
 <20170326160126.nwboar7mwztwxtgp@kozik-lap>
 <CANc+2y4xkDs2kQGXKP=8i_v9oYw4dPKTjWs0xFnvOcwDbar47g@mail.gmail.com>
 <1535446.zHpTqe8jba@positron.chronox.de>
Message-ID: <20170326180959.rmps6pj5376l45fz@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 26, 2017 at 07:05:48PM +0200, Stephan M?ller wrote:
> Am Sonntag, 26. M?rz 2017, 18:46:02 CEST schrieb PrasannaKumar Muralidharan:
> 
> Hi 	Krzysztof,
> 
> > >> > +       if (slen < EXYNOS_RNG_SEED_SIZE) {
> > >> > +               dev_warn(rng->dev, "Seed too short (only %u bytes)\n",
> > >> > slen); +               return -EINVAL;
> > >> > +       }
> > >> 
> > >> Will it be helpful to print the required seed size?
> > > 
> > > It is in /proc/crypto... It is not a problem to print it but isn't that
> > > redundant?
> > 
> > Not necessary if it is already available.
> 
> Maybe the dev_warn should be removed. Note, unprivileged user space can 
> trigger this warning by simply invoking the seeding operation over and over 
> again with an insufficient seed size. This would clutter the log.

Makes sense. The generic dev_dbg() before would bring enough
information.

Best regards,
Krzysztof
