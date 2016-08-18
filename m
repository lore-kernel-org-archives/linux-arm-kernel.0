From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 18 Aug 2016 13:28:58 -0500
Subject: [PATCH v2 1/4] nvmem: rockchip-efuse: Change initcall to subsys
In-Reply-To: <1471510341-63926-2-git-send-email-finley.xiao@rock-chips.com>
 (Finlye Xiao's message of "Thu, 18 Aug 2016 16:52:18 +0800")
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <m2mvkaq6c5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finlye Xiao <finley.xiao@rock-chips.com> writes:

> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> We will register a cpufreq notifier for adjusting opp's voltage, and it
> need to fetch cpu's leakage from efuse in the notifier_call. so the efuse
> driver should probe before cpufreq driver.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Why can't this be handled with deferred probling?  initcall ordering is
a can of worms.

Kevin
