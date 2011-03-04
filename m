From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 4 Mar 2011 11:17:08 +0100
Subject: [PATCH] ARM: twd: Adjust localtimer frequency with cpufreq
	notifiers
In-Reply-To: <1290060899-9786-1-git-send-email-ccross@android.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com>
Message-ID: <AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/18 Colin Cross <ccross@android.com>:

> The clock to the ARM TWD local timer scales with the cpu
> frequency. To allow the cpu frequency to change while
> maintaining a constant TWD frequency, pick a lower target
> frequency for the TWD and use the prescaler to divide down
> to the closest lower frequency.

We are using this with some custom hooks for the U8500.

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Martin Persson can probably provide an additional Tested-by
from ST-Ericsson if it helps.

Colin are you merging this patch for 2.6.39 through
Russells tracker or pull request? It's an important patch
for us.

Yours,
Linus Walleij
