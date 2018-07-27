From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Fri, 27 Jul 2018 15:10:32 +0800
Subject: [PATCH v1] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <cd4706970b40b49373ad169e3f9651f29508194a.camel@collabora.com>
 (Ezequiel Garcia's message of "Thu, 26 Jul 2018 10:41:58 -0300")
References: <1532589205-10153-1-git-send-email-djw@t-chip.com.cn>
 <cd4706970b40b49373ad169e3f9651f29508194a.camel@collabora.com>
Message-ID: <871sbpm9w7.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel@collabora.com> writes:

> On Thu, 2018-07-26 at 15:13 +0800, djw at t-chip.com.cn wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>> 
>> ROC-RK3399-PC is a power efficient 4GB LPDDR4 single board
>> computer with USB 3.0 and Gigabit Ethernet in a form factor
>> compatible with the Raspberry Pi. It is based on the Rockchip
>> RK3399 SoC, powered by the Type-C port.
>> 
>> The devicetree currently supports peripherals of:
>> 
>> - Ethernet
>> - HDMI
>> - SD Card
>> - UART2 debug
>> - TYPE-C
>
> Hi Levin,
>
> Last time I tried to make the mainline fusb driver work, it really didn't.
> Is USB 3.0 Type-C actually working with mainline on this board?
>
> Thanks!
> Eze

That's what I added in the end:

  USB3 in type-c port currently only works with normal orientation,
  not flip one.

Adding 'extcon=<&fusb0>' to make the dwc3 core failed to initialize.

Regards,
Levin
