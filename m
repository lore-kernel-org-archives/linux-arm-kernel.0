From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Feb 2013 11:01:12 -0700
Subject: [PATCH V2] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <1360605395.2028.28.camel@joe-AO722>
References: <1360605099-7088-1-git-send-email-swarren@wwwdotorg.org>
 <1360605395.2028.28.camel@joe-AO722>
Message-ID: <511931E8.3080802@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 10:56 AM, Joe Perches wrote:
> On Mon, 2013-02-11 at 10:51 -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The intent is to ensure that all Tegra-related patches are sent to the
>> linux-tegra@ mailing list, so people can keep up-to-date on all misc
>> driver changes.
>>
>> Doing this with a keyword is far simpler and more compact than listing
>> all Tegra-related drivers, even if wildcards were used.
>>
>> Words such as integrate or integrator are common. Ensure the character
>> right before "tegra" isn't a-z (case-insensitive), to make sure the
>> keyword doesn't match those.
>>
>> Cc: Joe Perches <joe@perches.com>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  MAINTAINERS |    4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b98c89b..10e9b31 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7829,9 +7829,7 @@ L:	linux-tegra at vger.kernel.org
>>  Q:	http://patchwork.ozlabs.org/project/linux-tegra/list/
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
>>  S:	Supported
>> -F:	arch/arm/mach-tegra
>> -F:	arch/arm/boot/dts/tegra*
>> -F:	arch/arm/configs/tegra_defconfig
>> +K:	(?i)[^a-z]tegra
>>  
>>  TEHUTI ETHERNET DRIVER
>>  M:	Andy Gospodarek <andy@greyhouse.net>
> 
> It's probably not a good idea to remove
> any of the F: lines as there are files
> that could get modified in those paths
> without any tegra word in the patch.

At least for those F: lines that exist already and are removed above,
the keyword will match their filename, so there's no issue here.
