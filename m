From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 01 Jun 2014 11:23:48 +0200
Subject: [linux-sunxi] [PATCH v2 1/4] dt: bindings: mmc: Document the
 practice of using subnodes for slots
In-Reply-To: <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>	<1401563014-13856-2-git-send-email-hdegoede@redhat.com>
 <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
Message-ID: <538AF124.9040106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/31/2014 10:13 PM, Olof Johansson wrote:
> On Sat, May 31, 2014 at 12:03 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The following existing MMC host controller bindings use slot subnodes:
>>
>> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>> Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
>> Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
>> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>>
>> This commit documents this practice in the standard mmc bindings documentation.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> There are today only two drivers that use this kind of binding, dw_mmc
> and the at91 one.

Correct.

> Neither seems to actually ever have been used with
> more than one slot. I doubt anyone building an exynos-based system
> will ever do a multi-slot solution, and it seems that the at91 driver
> doesn't actually handle more than one slot.
>
> I'm personally not that excited about complicating the bindings by
> opening up for this -- I would rather work towards removing the
> concept of slots if it's one of those things that are going to remain
> unused. We have actually been talking about reworking the dw_mmc
> binding to remove the slot concept (and simplify the driver by doing
> so).

I'm fine with removing the slot subnode, I added it because of it being
brought up in the powerup sequence discussion. I explicitly asked there
if adding such a subnode level was seen as desirable but nobody
answered :|

Anyways, either way works for me. I can do a v3 dropping the slot subnode
level again. I would really like to move forward with a decision on how-to
represent non probable info for sdio devices in device nodes. So do you
have any other remarks other then that the slot subnode should be dropped ?
And if not can you please review and ack (*) v3 of this patch-set once
I've send it?

Chris Ball and Ulf Hansson, what is your take on this, are you willing to
take this patch set? And do you want it with or without the slot subnodes ?

Thanks & Regards,

Hans


*) Assuming you don't find any issues
