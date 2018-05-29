From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 May 2018 15:15:01 -0700
Subject: Regression in Linux next again
Message-ID: <20180529221501.GJ5702@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Linux next has a regression at least on beaglebone-x15 where
booting Linux hangs shortly after starting init when loading
modules with no output. I bisected it down to commit
456e7cdf3b1a ("regulator: core: Change voltage setting path")

I think I bisected this same issue for the second time now
but for a different merge window. What's up with that?

And then we also have commit 696861761a58 ("regulator: core: Add
voltage balancing mechanism") that fails to compile breaking
git bisect:

drivers/regulator/core.c: In function 'regulator_balance_voltage':
drivers/regulator/core.c:3284:9: error: implicit declaration of
function 'regulator_set_voltage'.

Reverting both patches fixes the issue for me. I could
not debug it further because of the compile error(s).

Regards,

Tony
