From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 12:33:41 -0300
Subject: [PATCH 7/7] ARM: mvebu: Enable perf support in mvebu_v7_defconfig
In-Reply-To: <20141022141127.GN22642@leverpostej>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-8-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022141127.GN22642@leverpostej>
Message-ID: <5447CE55.6020808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 11:11 AM, Mark Rutland wrote:
> On Wed, Oct 22, 2014 at 02:43:47PM +0100, Ezequiel Garcia wrote:
>> Now that Armada 375/38x have support for the PMU, this commit enables perf
>> events in the defconfig.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> ---
>>  arch/arm/configs/mvebu_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
>> index ed0a0d1..d1a4669 100644
>> --- a/arch/arm/configs/mvebu_v7_defconfig
>> +++ b/arch/arm/configs/mvebu_v7_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
>>  CONFIG_LOG_BUF_SHIFT=14
>>  CONFIG_BLK_DEV_INITRD=y
>>  CONFIG_EXPERT=y
>> +CONFIG_PERF_EVENTS=y
> 
> Isn't this provided by CONFIG_ARM already?
> 

No, you need to select it explicitly, as the other platforms do.

> Surely you want CONFIG_HW_PERF_EVENTS?
> 

Yes, but it defaults to 'yes' if PERF_EVENTS is enabled, so you don't
need it in the defconfig.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
