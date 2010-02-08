From: maz@misterjones.org (Marc Zyngier)
Date: Mon, 8 Feb 2010 12:32:38 -0000 (GMT)
Subject: Using PXA arm board with MAX7319 GPIO expander input
In-Reply-To: <20100208113306.GN9007@buzzloop.caiaq.de>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
	<f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
	<bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
	<bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
	<20100208113306.GN9007@buzzloop.caiaq.de>
Message-ID: <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I just saw that there is indeed no support for irq line handling in this
> driver. In order to use these lines as input for something like the
> gpio_keys driver, support for that should be added. I never used this
> driver and can't say whether it is under active development.

It should be rather easy to introduce something similar to what I did for
the pca953x driver (http://patchwork.kernel.org/patch/77418/)

MAX732x seems a lot saner than PCA953x, as it has at least a hardware
interrupt mask...

        M.
-- 
And if you don't know where you're going, any road will take you there...
