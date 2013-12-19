From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 23:17:44 +0100
Subject: [rtc-linux] Re: Can someone Ack and queue a patch for RTC
 subsytem?
In-Reply-To: <20131219175738.1dad3ade@linux.lan.towertech.it> (Alessandro
 Zummo's message of "Thu, 19 Dec 2013 17:57:38 +0100")
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <20131219175738.1dad3ade@linux.lan.towertech.it>
Message-ID: <8761qk32pj.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alessandro Zummo <a.zummo@towertech.it> writes:

> On Thu, 19 Dec 2013 11:46:24 -0500
> Jason Cooper <jason@lakedaemon.net> wrote:
>
>> In the long term, should we seek out a co-maintainer for drivers/rtc?
>> Can anyone get a hold of Alessandro to get his opinion on this?
>
>  I'd surely appreciate if someone can take some time to give
>  a look to the patches. Most of them go thru subsystem's tree and, as
>  far as I can see, I saw very relevant comments and fixes in all those
>  years.

While I am at it, I wonder if you can give me some directions on the
following to add back alarm support to the ISL12057 on the specific
hardware I have.

All NETGEAR ReadyNAS 102, 104 and 2120 have an ISL 12057 RTC chip which
is used as main RTC clock but can also provide alarm. But the alarm
interrupt line of the chip is *not* connected to the SoC. It is
connected to some power component and can be used to wake up the NAS
when it is completely off and the alarm rings.

To me this kind of setup seems logical but it does not seem to be
directly supported by current RTC logic:

 - first, I cannot test an interrupt handler implementation I had
   written as the SoC will never receive any interrupt. This limits
   my ability to provide one to the driver.
 - what can/should be done in my .dts file to indicate that the
   device does not have any IRQ line connected (and hence no interrupt
   handler) to the SoC but still supports an alarm.

As a side note, the implementation I had was a working one on my
hardware (i.e. was able to wake up the device at a given time) but I had
to remove alarm code to get a basic driver accepted upstream.

To be honest, I tried and understand what RTC subsystem expects from
documentation and code w/o success. Any help appreciated on that topic.

Cheers,

a+
