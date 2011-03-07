From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 7 Mar 2011 15:37:38 +0000
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <87oc5puwg3.fsf@lebrac.rtp-net.org>
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	<87oc5puwg3.fsf@lebrac.rtp-net.org>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Just to verify that you are testing on an MX51-Babbage board? Here's my log:

root at freescale ~$ uname -a
Linux freescale 2.6.38-rc1+ #93 Fri Mar 4 17:18:15 CST 2011 armv7l GNU/Linux
root at freescale ~$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

<Press power key here, and the wake up is the bottom>.

PM: suspend of devices complete after 0.835 msecs
PM: suspend devices took 0.000 seconds
PM: late suspend of devices complete after 0.159 msecs
PM: early resume of devices complete after 0.187 msecs
PM: resume of devices complete after 81.911 msecs
PM: resume devices took 0.090 seconds
Restarting tasks ... done.
root at freescale ~$


Thanks,

Dinh

>-----Original Message-----
>From: Arnaud Patard [mailto:arnaud.patard at rtp-net.org]
>Sent: Saturday, March 05, 2011 2:47 PM
>To: Nguyen Dinh-R00091
>Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
>s.hauer at pengutronix.de; u.kleine-koenig at pengutronix.de; Zhang Lily-R58066; Vaidyanathan Ranjani-RA5478
>Subject: Re: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
>
>Nguyen Dinh-R00091 <R00091@freescale.com> writes:
>
>> Hi Arnaud,
>
>Hi,
>
>>
>> I just sent out a 2nd set of the MX51 LPM patch. I have tested successfully on my mx51 babbage
>without any code modifications.
>>
>> If you would kindly verify on your side, that would great.
>>
>> You need both patches:
>>
>> [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
>> [PATCHv2 2/2] ARM: mx51: Add support for low power suspend on MX51
>
>No success. I even tried disabling nearly all drivers and nothing. The
>last line I have in the serial console is :
>
>PM: late suspend of devices complete after 0.354 msecs
>
>So, I still don't know if the system is crashing while suspending or if
>the system is suspended but doesn't wake up.
>
>Arnaud
