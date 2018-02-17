From: s-anna@ti.com (Suman Anna)
Date: Fri, 16 Feb 2018 19:40:43 -0600
Subject: syscon regmap for disabled node?
Message-ID: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj, Arnd, Lee,

I am testing some code to use a syscon/regmap interface and I find that
the syscon/regmap is initialized even on a disabled device node using a
"syscon" compatible property when I have expected it to fail. Prior to
commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
platform devices"), the driver would have never probed, and the
of_syscon_register() only checks for the compatible, but not if the
device node is available. Is this intentional or a bug?

regards
Suman
