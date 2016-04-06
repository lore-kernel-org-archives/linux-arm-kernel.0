From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 6 Apr 2016 11:32:13 -0600
Subject: [PATCH] ARM: tegra: fix naming in GPIO DT binding header
In-Reply-To: <20160406172845.GC28843@ulmo.ba.sec>
References: <1459884307-24043-1-git-send-email-swarren@wwwdotorg.org>
 <20160406172845.GC28843@ulmo.ba.sec>
Message-ID: <5705481D.3030700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2016 11:28 AM, Thierry Reding wrote:
> On Tue, Apr 05, 2016 at 01:25:07PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> According to the Tegra TRM, GPIOs are aggregated into /ports/ of 8 GPIOs,
>> not into /banks/. Fix <dt-bindings/gpio/tegra-gpio.h> to correctly reflect
>> this naming convention. While this seems like silly churn, it will become
>> slightly more important once we introduce the GPIO binding for upcoming
>> Tegra chips.
>>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>   include/dt-bindings/gpio/tegra-gpio.h | 68 +++++++++++++++++------------------
>>   1 file changed, 34 insertions(+), 34 deletions(-)
>
> It's not clear to me where this should be applied. This is technically
> part of the GPIO controller bindings, in which case it'd need to go via
> the GPIO tree. I'm fine with taking it through the Tegra tree, too, but
> in case you agree that it should go through the GPIO tree:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

I typically consider bindings part of the SoC code-base they related to, 
so I'd imagine this going through the Tegra tree. I didn't Cc LinusW on 
the patch because of that thinking and oversight, but have done so now 
just in case he feels strongly.
