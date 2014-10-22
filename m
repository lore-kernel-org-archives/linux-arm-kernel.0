From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 22 Oct 2014 09:36:15 +0200
Subject: [PATCH] MAINTAINERS: Update Zynq maintainer record
In-Reply-To: <1413960882.18654.2.camel@perches.com>
References: <1413927103-31358-1-git-send-email-soren.brinkmann@xilinx.com>
 <ba5ded105f25449a8ccd35f3109ff2de@BL2FFO11FD019.protection.gbl>
 <1413960882.18654.2.camel@perches.com>
Message-ID: <7f1a322b4d7b481ea8b316736fe6b24a@BL2FFO11FD025.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 08:54 AM, Joe Perches wrote:
> On Wed, 2014-10-22 at 08:29 +0200, Michal Simek wrote:
>> On 10/21/2014 11:31 PM, Soren Brinkmann wrote:
>>>  - add myself as reviewer for Zynq
>>>  - add entry to cover Zynq clock drivers
>>>  - add entry to cover Xilinx DMA drivers
>>>
>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>> ---
>>>  MAINTAINERS | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a20df9bf8ab0..07eecdddbe8b 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1543,6 +1543,7 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
>>>  
>>>  ARM/ZYNQ ARCHITECTURE
>>>  M:	Michal Simek <michal.simek@xilinx.com>
>>> +R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
>>
>> this is fine.
>>
>>>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>  W:	http://wiki.xilinx.com
>>>  T:	git git://git.xilinx.com/linux-xlnx.git
>>> @@ -1552,7 +1553,9 @@ F:	drivers/cpuidle/cpuidle-zynq.c
>>>  F:	drivers/block/xsysace.c
>>>  N:	zynq
>>>  N:	xilinx
>>> +F:	drivers/clk/zynq/
>>
>> this is handled by N: zynq
>>
>>>  F:	drivers/clocksource/cadence_ttc_timer.c
>>> +F:	drivers/dma/xilinx/
>>
>> ditto.
> 
> F: specific paths are better than N: file names
> because get_maintainers doesn't add the patches
> submitters for N: entries.

I expect that you are referring to this description

        N: Files and directories with regex patterns.
           N:   [^a-z]tegra     all files whose path contains the word tegra
           One pattern per line.  Multiple N: lines acceptable.
           scripts/get_maintainer.pl has different behavior for files that
           match F: pattern and matches of N: patterns.  By default,
           get_maintainer will not look at git log history when an F: pattern
           match occurs.  When an N: match occurs, git log history is used
           to also notify the people that have git commit signatures.

The purpose of this patch was that Soren is aware about changes
around xilinx drivers not to sign dma drivers to me + CC him.

Also this fragment informing me that something is happening around these drivers
and also driver submitter is informed that's why using git log history is
at least for me preferred way.

Thanks,
Michal
