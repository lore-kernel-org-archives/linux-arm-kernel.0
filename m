From: ssimran@broadcom.com (simran rai)
Date: Fri, 30 Oct 2015 16:36:05 -0700
Subject: [PATCH 2/2] sound: soc: Add Cygnus audio driver
In-Reply-To: <3878425.UJmmiCl69s@wuerfel>
References: <201510310722.jTEbgeBu%fengguang.wu@intel.com>
 <3878425.UJmmiCl69s@wuerfel>
Message-ID: <5633FEE5.7050101@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


On 10/30/2015 4:28 PM, Arnd Bergmann wrote:
> On Saturday 31 October 2015 07:20:17 kbuild test robot wrote:
>>   > 785          dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
>>     786                                  __func__, size, buf->area);
>>
> Both reports are for the same bug: the "0x%x" should be "0x%zx".
>
> There is another bug in the same line: "0x%p" should be "%pK",
> to avoid the duplicate "0x" and to not leak the pointer when
> kptr_restrict is set.
>
> 	Arnd
I will fix both of these in the next patchset, early next week. If there 
are any other comments/suggestions, please let me know. Thanks for the 
feedback.

Simran
