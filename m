From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 24 Aug 2015 11:18:19 +0200
Subject: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
In-Reply-To: <20150824080800.GG13155@piout.net>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net> <55DACC5A.80707@xilinx.com>
 <20150824080800.GG13155@piout.net>
Message-ID: <55DAE15B.6090602@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/24/2015 10:08 AM, Alexandre Belloni wrote:
> On 24/08/2015 at 09:48:42 +0200, Michal Simek wrote :
>> On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
>>> On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
>>>> adds support for RTC controller found on
>>>> Xilinx Zynq Ultrascale+ MPSoC platform.
>>>>
>>>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>>>> ---
>>>> Changes v3 
>>>> - fix checkpatch errors 
>>>> - check time in secs arg against max sec val 
>>>> - order header files 
>>>> - use ptr_err_or_zero macro 
>>>> - use time64 variants 
>>>> Changes v2 
>>>> - change alm to alarm 
>>>> ---
>>>>  drivers/rtc/Kconfig      |   7 ++
>>>>  drivers/rtc/Makefile     |   1 +
>>>>  drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 287 insertions(+)
>>>>  create mode 100644 drivers/rtc/rtc-zynqmp.c
>>>>
>>> Applied, thanks.
>>>
>>
> 
> Actually, I got the following message:
> A message that you sent could not be delivered to one or more of its
> recipients. This is a permanent error. The following address(es) failed:
> 
>   suneel.garapati at xilinx.com
>     Unknown User
> 
> I'm not fond of carrying patches with uncontactable authors. Is that a
> permanent error?

Unfortunately. That guy left Xilinx last week but don't be scared that
none will be responsible about this driver. I have well proven history
on Linux and others project and I am here if you need to do some testing
or ACK for changes. Just let me know when you need something.

get_maintainer returns me and Soren that's why you shouldn't have any
problem with it.

[linux]$ ./scripts/get_maintainer.pl -f drivers/rtc/rtc-zynqmp.c
Alessandro Zummo <a.zummo@towertech.it> (maintainer:REAL TIME CLOCK
(RTC) SUBSYSTEM)
Alexandre Belloni <alexandre.belloni@free-electrons.com>
(maintainer:REAL TIME CLOCK (RTC) SUBSYSTEM)
Michal Simek <michal.simek@xilinx.com> (supporter:ARM/ZYNQ ARCHITECTURE)
"S?ren Brinkmann" <soren.brinkmann@xilinx.com> (reviewer)
rtc-linux at googlegroups.com (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
linux-arm-kernel at lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE)
linux-kernel at vger.kernel.org (open list)

Thanks,
Michal
