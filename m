From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 09 Jan 2015 00:29:25 +0900
Subject: [PATCH v2] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1420706948.6075.17.camel@collabora.co.uk>
References: <1417721269-19342-1-git-send-email-sjoerd.simons@collabora.co.uk>	
 <54AA48E6.3040404@samsung.com> <1420470469.15910.134.camel@collabora.co.uk>	
 <69242715.30115.1420655868687.JavaMail.yahoo@jws10659.mail.bf1.yahoo.com>	
 <1420670333.6075.2.camel@collabora.co.uk>	
 <6203C077F070A646AA0FCB4B5F1795D248114CA6@sisaex01sj>
 <1420706948.6075.17.camel@collabora.co.uk>
Message-ID: <54AEA255.1000100@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/15 17:49, Sjoerd Simons wrote:
> On Wed, 2015-01-07 at 23:49 +0000, Jonathan Stone -SISA wrote:
>>
>> On On Wed, 2015-01-07 at 18:37 +0000, Sjoerd Simons writes wrote:
>>> On Wed, 2015-01-07 at 18:37 +0000, Anand Moon wrote:>
>> [...]
>>
>>>> Only 4 core cpu's are on my board. Also CpuFreq is not working.
>>>
>>> Can you share some point on this.
>>
>>> The defconfig is using the bL switcher, which pairs up big and little cores to make them appear as one core.. So for 8 real cores, you'll get
>>> 4 "virtual cores".
>>
>> That configuration is appropriate for the 5420, which allegedly has a hardware bug in the cache-coherence between the Cortex-A7 block and the Cortex-A15 block.
>> Newer Exynos 5 SoCs -- 5422/5800, 5620, etc -- don't have that bug. The scheduler should configured to  do HMP on all 8 (or 6) cores.
>> I don't have a 5410, but I assume it has the same bug as the 5420.
> 
> Yes the kernel/scheduler could be configured like that, but
> exynos_defconfig turns on bL rather then HMP. 
> 
> Now it's not unthinkable to add code/dts properties to select the
> right/preferred scheduling strategy depending on the board (HMP vs. bL).
> But proper HMP scheduling is still a work in progress in mainline and
> iirc specifically on the XU3 there are open issue wrt. MCPM and its
> secure firmware. I've added Kevin to the CC as he's been working on this
> topic so should know the status a lot better then i do.
> 
>> The XU3 kernel supplied by HardKernel shows all 8 cores, and does HMP scheduling across all 8.
> 
> Yes, that's independant of the dts though as mentioned above. Also there
> are still opne issues to booting up all cores on an XU3 afaik. See 
>    http://www.spinics.net/lists/linux-samsung-soc/msg39523.html
> 
>> I tried v1.0 of the Odroid-XU3 DTB patch, applied to linux-next
>> 20150107.  I'm only seeing 1 core running on my Odroid-XU3.  The USB
>> 3.0 port works (great!) but I'm not getting any HDMI output. I didn't
>> try DisplayPort.   I'll gladly try v2 of the patch on an XU3; is there
>> a better base to apply the patch to?
> 
> HDMI output is broken on all exynos boards in mainline atm. For exynos
> 5, see the thread here:
>  http://www.spinics.net/lists/linux-samsung-soc/msg40708.html
> 
> As far as a i know with the DTS as posted (just posted v3 with a small
> improvement), all base functionality that can work on mainline (MMC/SD,
> network, USB2, USB3) works. Some less important bits (fan control &
> power sensors) are outstanding, but that really shouldn't block the
> merge of the DTS.
> 
Sjoerd, thanks. I'll take your updated patch once you submit version3.

- Kukjin
