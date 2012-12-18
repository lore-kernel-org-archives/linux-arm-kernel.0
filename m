From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Dec 2012 09:55:17 -0700
Subject: [PATCH 2/4] ARM: tegra: add connection name for uart clock table
In-Reply-To: <50D015B5.8050805@nvidia.com>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
 <1355746101-15291-3-git-send-email-ldewangan@nvidia.com>
 <50CF9233.3010506@wwwdotorg.org> <50D015B5.8050805@nvidia.com>
Message-ID: <50D09FF5.7050901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 12:05 AM, Laxman Dewangan wrote:
> On Tuesday 18 December 2012 03:14 AM, Stephen Warren wrote:
>> On 12/17/2012 05:08 AM, Laxman Dewangan wrote:
>>> Add connection name "uart-clk" for the uart clock information.
>>
>> Does the UART receive more than one clock, so that it actually cares
>> what the clock connection name is? If not, can we just drop this patch?
> 
> I like to have this patch because:
> - In future, I want to also get the name of the clock source and set
> parent of uart clock properly.

I don't understand that; drivers should not care about the names of
clocks; the names will be entirely irrelevant once we get clocks from DT.

> - I want to switch the parent clock source dynamically between CLKM and
> PLLP to achieve more power optimization i.e. use CLKM wherever possible..

I'd prefer to defer that until after we get clocks from DT. Otherwise,
we're just adding more churn to the old clock driver first. It'd be
better to just switch to the new clock driver, put all the clocks in DT,
and then build on that.
