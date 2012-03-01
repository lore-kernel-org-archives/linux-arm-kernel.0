From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 1 Mar 2012 10:41:43 -0600
Subject: [PATCH] efikamx: match machine descriptions with legacy
In-Reply-To: <CAODfWeG4OpH1VkWOuHntUCygC8YVMfgTK=1onDweAZ8WYW6w+Q@mail.gmail.com>
References: <1329779368-27878-1-git-send-email-hector.oron@gmail.com>
 <CAHLCerPwJpM7x6WJ=1FUwJ96X-rgfLUEN840eoJ3SQsHg5gBDA@mail.gmail.com>
 <CAODfWeG4OpH1VkWOuHntUCygC8YVMfgTK=1onDweAZ8WYW6w+Q@mail.gmail.com>
Message-ID: <CAKGA1bnrQd9FpgfZpYu=_BiWNd5A+SP7GNfU9qsEJ3TFw4d-vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 10:49 AM, Hector Oron <hector.oron@gmail.com> wrote:
> Hello,
>
> 2012/2/23 Amit Kucheria <amit.kucheria@linaro.org>:
>> On Tue, Feb 21, 2012 at 1:09 AM, Hector Oron <hector.oron@gmail.com> wrote:
>
>>> ?Rename machine descriptions to match legacy descriptions distributed by
>>> ?manufacturer BSP. This way distributions can do clean upgrades from
>>> ?userspace scripts which check for these values to differentiate platforms
>>> ?with single kernel binaries.
>>>
>>> Signed-off-by: Hector Oron <hector.oron@gmail.com>
>>> Acked-by: Matt Sealey <matt@genesi-usa.com>
>
>> This is likely to break flash-kernel used in debian/ubuntu/linaro I
>> suspect. Can you fix that too?
>
> Surely, I can and I will do.
>
>> Otherwise,
>> Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

Thanks, Amit.

The patch is predicated on two things. Firstly that it unifies
behavior and the board identification across both BSP kernels and
mainline kernels, which is not up for argument on which is more
"correct" (vendor defines this, it is not a random freeform string of
the pusher's choosing, more importantly it is something at least 2
userspace tools use as input to seek board type and therefore is under
some restriction to change).

Secondly, upstream flash-kernel never worked on Debian or Ubuntu
anyway (patches sent upstream were needlessly rewritten to the point
that they actually simply did not work to produce a bootable kernel
image set, and pushed to Debian therefore breaking any chance of
Debian or Ubuntu supporting the board) and Linaro don't support the
EfikaMX with their MX5 kernels.

So this breaks nobody currently, but we actually want to get this
stuff done right upstream.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
