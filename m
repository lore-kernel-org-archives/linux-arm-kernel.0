From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 28 Oct 2010 14:14:14 -0400
Subject: [PATCH v4 01/12] misc: add driver for sequencer serial port
In-Reply-To: <4CC9A03F.80401@ti.com>
References: <1288124308-14999-1-git-send-email-cyril@ti.com>
	<1288124308-14999-2-git-send-email-cyril@ti.com>
	<AANLkTi=rDep3jkp2QAjVsgjZ7JQ0ysnse4TARv29fyHm@mail.gmail.com>
	<4CC9A03F.80401@ti.com>
Message-ID: <AANLkTinOROf6OqTjN0tZgoDr5ij3J18DHpC8wwArH3CO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/28 Cyril Chemparathy <cyril@ti.com>:
> On 10/28/2010 11:49 AM, Linus Walleij wrote:
>> Why is this thing in drivers/misc?
>> drivers/mfd is IMHO the apropriate place for a driver like this, (...)
>
> Alan had raised the same concern earlier, and my response was:
>
>[Cyril]
>> Unlike MFDs, this device doesn't have cells with differing
>> functionality. ?Instead it has functionally identical ports that can
>> operate in a variety of modes. ?That said, does this still fit in with
>> other MFD drivers? ?If so, I don't see a problem with moving it there.
>
> I don't see a problem with moving this into MFD, but this won't be able
> to use any of the functionality provided by mfd-core.

I think they do have differing functionality, though not in their
essence (hardware), they do get a clearly defined role at
run-time.

Sam will tell, but since you have subdrivers in other
subsystems MFD fits best IMHO.

What about the platform data passed into the MFD driver defines
what type of functionality will be assigned to each physical
block, from that you create the array of MFD cells to be spawn
and spawn it off. Then you have platform_driver:s in each
subsystem attaching to said cells. Shouldn't be too hard.

Yours,
Linus Walleij
