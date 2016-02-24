From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 12:20:35 -0800
Subject: [PATCH] ARM: dts: spear: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1455032699-3086-1-git-send-email-sudeep.holla@arm.com>
References: <1454968535-11994-1-git-send-email-sudeep.holla@arm.com>
 <1455032699-3086-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160224202035.GE10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 03:44:59PM +0000, Sudeep Holla wrote:
> Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
> "gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
> source.
> 
> Few dts files assign value "1" to gpio-key,wakeup which is incorrect.
> Since the presence of the boolean property indicates it is enabled,
> value of "0" or "1" have no significance.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property which inturn fixes the above mentioned issue.
> 
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/spear1310-evb.dts | 2 +-
>  arch/arm/boot/dts/spear1340-evb.dts | 2 +-
>  arch/arm/boot/dts/spear320-hmi.dts  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> (this time adding arm at kernel.org correctly)
> 
> Hi ARM-SoC guys,
> 
> This is the only platform which doesn't have regular pull request,
> Viresh has acked it already. Can you pick this up directly for v4.6 ?

Thanks, applied.


-Olof
