From: venkappa.m@samsung.com (Venkappa Mala)
Date: Thu, 19 Feb 2015 12:26:01 +0000 (UTC)
Subject: [PATCH v10 4/6] ARM: add vdso user-space code
References: <1411413485-7675-1-git-send-email-nathan_lynch@mentor.com>
 <1411413485-7675-5-git-send-email-nathan_lynch@mentor.com>
 <loom.20150213T053547-381@post.gmane.org> <54E24D7B.3050806@mentor.com>
Message-ID: <loom.20150219T130553-695@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nathan Lynch <Nathan_Lynch <at> mentor.com> writes:

> Hi,
> 
> Sorry for not seeing this earlier but it doesn't look like my address
> was in the recipients list, and I just happened to catch up on list
> traffic today.
> 
> It looks like Catalin already covered everything, but just to sum up -
-
> the patches need to be updated to avoid enabling the VDSO gettimeofday
> on systems where CNTVCT is not usable, for whatever reason.  I do not
> intend to enable user space / VDSO access to CNTPCT to accommodate
> systems that don't initialize the virtual counter/offset correctly.
> 

Hello Nathan,

Now, it's clear about current vDSO patch set and it is validated with 
virtual timer/VCT by using workaround with the below results on
ARMv7-A: CortexA7: Quad core, 1.2GHz,

About 1 iteration (gettimeofday),
WITHOUT VDSO   : 30-35 ?sec 
WITH VDSO      : 4-7 ?sec

About 1000 iteration (gettimeofday),
WITHOUT VDSO   : 27-30 msec 
WITH VDSO      : 13-15 msec

As you have mentioned about avoid enabling the VDSO gettimeofday
on systems where CNTVCT is not usable, for whatever reason, please take 
care about this one in the updated patch list so that the things will be 
very clean.
Meanwhile, i will discuss further on "firmware is broken about CNTVOFF 
initialization zero + HYP disabled" in the following thread as mentioned 
in the previous reply to Catalin,
arm: Handle starting up in secure mode
https://lkml.org/lkml/2014/9/16/552

Thanks for the patch list,

BR,
Venkappa
