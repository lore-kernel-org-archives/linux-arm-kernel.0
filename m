From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 19 Dec 2013 18:28:16 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219173857.0a546b99@linux.lan.towertech.it> (Alessandro
 Zummo's message of "Thu, 19 Dec 2013 17:38:57 +0100")
References: <87siton6ke.fsf@natisbad.org>
 <20131219173857.0a546b99@linux.lan.towertech.it>
Message-ID: <87d2kslphr.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alessandro Zummo <a.zummo@towertech.it> writes:

> On Thu, 19 Dec 2013 17:34:09 +0100
> arno at natisbad.org (Arnaud Ebalard) wrote:
>
>> I never heard of *listed* RTC maintainer during all the review process
>> on rtc-linux list (v0 sent in october); I dug the list archives and when
>> this previously happened, someone else (e.g. Andrew Morton) was kind
>> enough to handle the patches:
>
>  Yes, Andrew usually pick those. 

I guess he should be put in the MAINTAINERS file then. Otherwise,
get_maintainer.pl script can not do its job correctly and people
end up thinking you should be the one handling those.


> I do not maintain a separate tree due to most RTCs being specifit to a
> subsytem. 

I do not understand: the chip is generic, i.e. this is not a RTC chip
specific to a given SoC (like rtc-mv.c is for instance). Can you be
more specific?


>>   http://www.spinics.net/lists/arm-kernel/msg292187.html
>
>  Regarding your patch, please do not add entries to /proc.
>  Use sysfs if you need.

Well, this is what is currently described in the documentation
(Documentation/rtc.txt), in drivers/rtc/rtc-test.c driver and what
many drivers do (AFAICT, 22/125).

Additionally, I only provide some additional info for an existing
file: the /proc entry is created by the drivers/rtc/class.c as
soon as someone selects CONFIG_RTC_INTF_PROC.

Do you want me to send a v7 w/ the .proc helper removed or leave
things as they are and Ack the patch as is?

Cheers,

a+
