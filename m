From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 10 Jun 2016 16:02:16 +0100
Subject: [PATCH] ARM: tegra: fix missing include <soc/tegra/cpuidle.h>
In-Reply-To: <575ACFB5.4070706@nvidia.com>
References: <1465404897-16654-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160610142210.GN27142@ulmo.ba.sec> <575ACFB5.4070706@nvidia.com>
Message-ID: <82f77fc8-824c-3d36-74ae-a886753286e3@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/16 15:33, Jon Hunter wrote:
> 
> On 10/06/16 15:22, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Wed, Jun 08, 2016 at 05:54:57PM +0100, Ben Dooks wrote:
>>> The prototype of tegra_cpuidle_pcie_irqs_in_use() is missing
>>> from the cpuidle.c file, it is defined in <soc/tegra/cpuidle.h>
>>> so add that include to avoid the following warning:
>>>
>>> arch/arm/mach-tegra/cpuidle.c:51:6: warning: symbol 'tegra_cpuidle_pcie_irqs_in_use' was not declared. Should it be static?
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>> Cc: Alexandre Courbot <gnurou@gmail.com>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-tegra at vger.kernel.org
>>> ---
>>>  arch/arm/mach-tegra/cpuidle.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> I've been carrying a set of patches to fix these, and a couple of other
>> sparse warnings, in my tree locally, but never sent them out because
>> they were so trivial. I probably should've to avoid the duplication of
>> effort. Sorry about that.

Given it is likely that gcc warning flags will be updated
it'd be good to get these issues sorted out.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
