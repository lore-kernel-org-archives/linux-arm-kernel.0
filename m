From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 13 Oct 2015 20:38:41 +0530
Subject: [PATCH 2/2][UPDATE] ARM: dts: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <1444747133-22671-1-git-send-email-sudeep.holla@arm.com>
References: <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
 <1444747133-22671-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20151013150841.GZ5386@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-10-15, 15:38, Sudeep Holla wrote:
> Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
> "gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
> source.
> 
> Few dts files assign value "1" to gpio-key,wakeup and in one instance a
> value "0" is assigned probably assuming it won't be enabled as a wakeup
> source. Since the presence of the boolean property indicates it is
> enabled, value of "0" have no value.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property which inturn fixes the above mentioned issue.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/spear1310-evb.dts         | 2 +-
>  arch/arm/boot/dts/spear1340-evb.dts         | 2 +-
>  arch/arm/boot/dts/spear320-hmi.dts          | 4 ++--

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
