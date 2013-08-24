From: robherring2@gmail.com (Rob Herring)
Date: Sat, 24 Aug 2013 10:25:26 -0500
Subject: [PATCH v8 1/7] irqchip: vic: Parse interrupt and resume masks
 from device tree
In-Reply-To: <2159266.zeHHUDxisq@flatron>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
 <1500724.07LRpFtgcx@flatron> <5217DE06.3070005@wwwdotorg.org>
 <2159266.zeHHUDxisq@flatron>
Message-ID: <CAL_JsqJzLJkozUd1sh4xb2O0hwoALq67xKhc6hgCKO0VGYbmyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 6:04 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Friday 23 of August 2013 16:11:18 Stephen Warren wrote:
>> On 08/22/2013 05:22 PM, Tomasz Figa wrote:
>> > This patch extends vic_of_init to parse valid interrupt sources
>> > and resume sources masks from device tree.
>> >
>> > If mask values are not specified in device tree, all sources
>> > are assumed to be valid, as before this patch.
>>
>> Can you explain further why the VIC needs this information up-front?
>> Presumably it can accumulate it as devices request interrupts.
>
> It does not need this information just for operation, but this makes the
> hardware description more detailed and allows better sanity checking of
> interrupts being requested.
>
> To clarify, this is a mask of valid interrupt sources of the VIC, where
> set bit indicates that given signal is wired and clear bit that it is not.

I agree with Stephen here. The valid interrupts are the ones in the
DT. The reserved ones are the ones not present. If it is not needed
for the operation of the VIC, then remove it. The argument of sanity
checking could apply to all interrupt controllers.

Rob
