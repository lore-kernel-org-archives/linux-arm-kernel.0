From: johan@kernel.org (Johan Hovold)
Date: Fri, 22 Dec 2017 13:51:50 +0100
Subject: [PATCH v5 5/5] misc serdev: w2sg0004: add debugging code and
 Kconfig
In-Reply-To: <5816bfb9e7cab68591c133e20696d6188ebe70de.1512114577.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <5816bfb9e7cab68591c133e20696d6188ebe70de.1512114577.git.hns@goldelico.com>
Message-ID: <20171222125150.GJ3374@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 08:49:38AM +0100, H. Nikolaus Schaller wrote:
> This allows to set CONFIG_W2SG0004_DEBUG which will
> make the driver report more activities and it will turn on the
> GPS module during boot while the driver assumes that it
> is off. This can be used to debug the correct functioning of
> the hardware. Therefore we add it as an option to the driver
> because we think it is of general use (and a little tricky to
> add by system testers).
> 
> Normally it should be off.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/misc/Kconfig    |  8 ++++++++
>  drivers/misc/w2sg0004.c | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

I'd say say this does not belong in the kernel at all. And even if the
power-state test were to be allowed, most of the pr_debugs would
need to go. You really should be using dev_dbg and friends, which can
already be enabled selectively at run time using dynamic debugging.

Johan
