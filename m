From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 26 Apr 2014 23:37:57 +0100
Subject: can problems on socfpga [was Re: [PATCH v2 4/6] ARM: socfpga:
 dts: add can0+1]
In-Reply-To: <20140426203131.GA21832@amd.pavel.ucw.cz>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
 <20140404102815.GA9242@amd.pavel.ucw.cz>
 <20140425195319.GA3677@amd.pavel.ucw.cz>
 <1398457446.26387.0.camel@linux-builds1>
 <1398461518.3587.11.camel@dinh-ubuntu>
 <20140426093646.GE8730@amd.pavel.ucw.cz>
 <20140426203131.GA21832@amd.pavel.ucw.cz>
Message-ID: <6bf951b6-51e7-4b90-b054-9ba5b6e93874@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm not in the office (and fighting with my phone's email client) until 5th of May, however please rebase all your patches against the latest net/master from David Miller, as this tree includes all c_can fixes by Thomas.

Marc

(This probability end as a tofu)

On 26 April 2014 21:31:31 BST, Pavel Machek <pavel@denx.de> wrote:
>On Sat 2014-04-26 11:36:46, Pavel Machek wrote:
>> Hi!
>> 
>> > To get this working well, I had to install a few of the patches
>that
>> > Benedict Spranger submitted ([PATCH 05/16] c_can: use 32 bit access
>for
>> > D_CAN) on 9/9/2013.
>> > 
>> > I have the patches on our rocketboard branch
>> > (rocketboards.org/gitweb/?p=linux-socfpga-git;a=summary)
>> > 
>> > I planned to upstream these changes but there have been some major
>> > changes to CAN recently that may require some refactoring.
>> 
>> I ported those changes to 3.15-rc2 (but can't test them at the
>> moment).
>
>Ok, it seems it is possible to test CAN without actual can hardware
>using loopback:
>
>ip link set can0 up type can bitrate 125000 loopback on
>ifconfig can0 up
>candump can0 &
>cansend can0 "123#DEADBEEF"
>
>Moreover, it seems that previous two patches do the trick. Packets are
>now echoed as expected. (Ok, small question is "why twice", but I
>guess that's just CAN...?)
>
>root at sockit:~# ip link set can0 up type can bitrate 125000 loopback on
>c_can_platform ffc00000.d_can can0: setting BTR=1c31 BRPE=0000
>root at sockit:~# ifconfig can0 up
>root at sockit:~# candump can0 &
>root at sockit:~# cansend can0 "123#DEADBEEF"
>  can0  123   [4]  DE AD BE EF
>  can0  123   [4]  DE AD BE EF
>root at sockit:~# 
>
>Best regards,
>								Pavel
