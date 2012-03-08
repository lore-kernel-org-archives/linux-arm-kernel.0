From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Thu, 8 Mar 2012 09:58:39 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317EC8CA@DBDE01.ent.ti.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0BF41C8E81@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Jan 27, 2012 at 18:49:42, Nori, Sekhar wrote:
>> Hi Jon,
>>
>> On Tue, Jan 17, 2012 at 15:32:23, Nori, Sekhar wrote:
>>
>>> I was able to reproduce this on the EVM using v2.6.38 (works)
>>> and v3.2 + my patch (doesn't work). I just started poking some
>>> registers to see what is happening. Will keep you updated
>>> on any progress.
>>>
>>
>> Following patch fixes the issue of interrupt handler not getting
>> called. I tested it using GPIO3 on DM365. On applying this, I
>> see a constant rate of 4-5 interrupts per second on that line.
>> Yet to figure out what is triggering those. Anyway I will wait for
>> you to test this after you are back before sending this to Grant.
>
> Are you back? Did you get a chance to test this?

Hi, sorry about that. I was away for a month, and forgot about this.

Tested just now. It seems good, GPIO interrupts work under 3.2
with this patch same as they do if I revert the genirq change.

I noticed that something else is broken for me under 3.2 (my FPGA driver
fails to load bitstream) compared with 3.0, but that is also broken with
genirq reverted so I think it's a separate issue and your patch is good.

So,

Tested-By: Jon Povey <jon.povey@racelogic.co.uk>

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
