From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Tue, 13 Nov 2018 18:15:49 +0100
Subject: [PATCH 0/5] media: Allwinner A10 CSI support
In-Reply-To: <20181113175558.3bfa3e8d@windsurf>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <df54f2e6-e207-92de-767a-e356345a1a56@xs4all.nl>
 <20181113135259.onutfjtoi25afnfe@flea>
 <f07a0460-cdba-c1a5-acfd-66a39f447a5a@cisco.com>
 <20181113155227.62jjs3mpomwgr7xd@flea>
 <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
 <20181113175558.3bfa3e8d@windsurf>
Message-ID: <2d25e395-af73-e69b-dc8a-3d0956d668f9@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2018 05:55 PM, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 13 Nov 2018 17:00:25 +0100, Hans Verkuil wrote:
> 
>> Weird, if I build directly from that tarball, then v4l2-compliance should say:
>>
>> v4l2-compliance SHA: not available, 64 bits
>>
>> So that's what I expect to see from buildroot as well.
> 
> Indeed, that's strange, I see that the v4l2-compliance Makefile does:
> 
> version.h:
>         @if git -C $(srcdir) rev-parse HEAD >/dev/null 2>&1; then \
>                 echo -n "#define SHA " >$@ ; \
>                 git -C $(srcdir) rev-parse HEAD >>$@ ; \
>         else \
>                 touch $@ ; \
>         fi
> 
> which correctly uses $(srcdir), so it shouldn't go "up" the libv4l
> build folder and pick up the latest Buildroot commit SHA1. I'll have a
> quick look.

I think it does, actually. If the tar archive is unpacked inside the
checked-out buildroot git tree, then it will pick up the buildroot SHA.

I fixed v4l-utils to be a bit smarter about this:

https://git.linuxtv.org/v4l-utils.git/patch/?id=98b4c9f276a18535b5691e5f350f59ffbf5a9aa5

Regards,

	Hans
