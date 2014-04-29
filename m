From: george.cherian@ti.com (George Cherian)
Date: Tue, 29 Apr 2014 10:01:21 +0530
Subject: [PATCH] ARM: dts: am33xx: fix DMA support for the second USB
 interface
In-Reply-To: <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
References: <1398674237-4129-1-git-send-email-yegorslists@googlemail.com>
 <535E64EF.2020108@ti.com>
 <CAGm1_kt_yQZowthaFq=imM5J6=1FkJX_1LtRV7eEiqeursbDZQ@mail.gmail.com>
Message-ID: <535F2B19.7020300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/28/2014 9:47 PM, Yegor Yefremov wrote:
> On Mon, Apr 28, 2014 at 4:25 PM, George Cherian <george.cherian@ti.com> wrote:
>> On 4/28/2014 2:07 PM, yegorslists at googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> This patch creates unique DMA channels for the second USB
>>> interface, otherwise the second USB interface is not usable
>>> at all.
>> MUSB_DMA_NUM_CHANNELS is 15, so if you pass  any dma-names > 15 (>
>> rx15/tx15),
>> the dma_controller_create in musb_core.c fails and it falls back to PIO
>> mode.
> What's the proper fix for the DMA issue?
I could not understand what issue you are referring to.
In my setup I use both BBB and BBW (Beagle Bone Black/White)with one USB 
in host (USB1)
and one USB in gadget (USB0). I dont see any issues with DMA.

Can you be more specific?
>
> Yegor


-- 
-George
