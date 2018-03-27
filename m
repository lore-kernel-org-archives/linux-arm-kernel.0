From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 27 Mar 2018 11:25:48 +0200
Subject: [PATCH v3 0/8] ARM: davinci: complete the conversion to using
 the reset framework
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
Message-ID: <1522142748.3345.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-03-27 at 11:20 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patches 1-3 add necessary lookups/DT-properties.
> 
> Patches 4-6 fix issues found in the remoteproc davinci driver.
> 
> Patch 7 converts the davinci-rproc driver to the reset framework.
> 
> Patch 8 removes now dead code.
> 
> Philipp: it turned out that it's indeed better to use the reset
> controller's device name for the entry lookup.
> 
> Tested both in DT and legacy modes by booting the examples from
> ti-ipc-rtos recipe in meta-ti.
> 
> This series applies on top of David Lechner's common-clk-v9 branch[1]
> with Philipp Zabel's reset/next branch[2] pulled in.
> 
> It can be found in my github tree as well[3].
> 
> [1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9
> [2] git://git.pengutronix.de/git/pza/linux reset/next

I have moved the relevant patches onto a separate, immutable branch,
which is merged into reset/next:

  git://git.pengutronix.de/git/pza/linux reset/lookup

regards
Philipp
