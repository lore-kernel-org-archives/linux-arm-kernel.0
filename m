From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 05 Nov 2009 16:06:15 +0100
Subject: [PATCH] [RTC] Add Freescale MC13783 RTC driver
In-Reply-To: <4AF1C423.3010407@epfl.ch>
References: <1256330323-13300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1256373342-5294-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091101203443.GB18116@pengutronix.de> <4AF1C423.3010407@epfl.ch>
Message-ID: <4AF2E9E7.9050807@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valentin Longchamp wrote:
> Hi Uwe,
> 
> Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> On Sat, Oct 24, 2009 at 10:35:42AM +0200, Uwe Kleine-K?nig wrote:
>>> This driver provides support for the RTC part integrated into the
>>> Freescale MC13783 PMIC and bases on patch created earlier by Sascha
>>> Hauer.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-k?nig@pengutronix.de>
>>> Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
>>> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>> Cc: rtc-linux at googlegroups.com
>>> ---
>>> Hello,
>>>
>>> this patch depends on
>>>
>>> 	mfd/mc13783: near complete rewrite
>>>
>>> sent earlier on lkml[1].  Compared to the earlier version of rtc support
>>> on mc13783 as sent by Sascha, this driver got reset detection and
>>> therefore depends on the patch above.
>>>
>>> A tree runnable on Phytec's PCM038 is available in my git tree
>>>
>>> 	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783
>>>
>>> .  (Maybe I will rewrite these commits, so please expect it might change
>>> in a non-fast-forward manner.)
>> Valentin, could you already test this?  Any comments by the others?
>>
> 
> I have tested your patches (taken your mc13783 branch today, and merged 
> it into my patches rebased on 2.6.32-rc6).
> 
> Your mfd/mc13783 rewrite seems to work for me (but since there is no 
> real usage for now, I don't use ADC yet and regulator don't do a lot). 
> But it runs fine on my hardware.
> 
> However, I get the hctosys: unable to read the hardware clock error 
> message at boot (from drivers/rtc/hctosys.c:62). Is it normal ?
> 
> Furthermore, the date and time are saved during system off, but the time 
> is not updated: if I shut down the system during 10 minutes, my time 
> will get a 10 minute delay. Is this a normal behavior with you current 
> implementation or is there something we have wrong in our design/code 
> (we have battery for the mc13783) ? I will have a further look at this 
> later, didn't have time now.
> 

This was due to a small hardware problem on our platform. Your RTC 
driver now works well on mx31moboard. Please consider my ackey-by:

Ackey-by: Valentin Longchamp <valentin.longchamp@epfl.ch>

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
