From: sr@denx.de (Stefan Roese)
Date: Mon, 29 Aug 2016 12:07:16 +0200
Subject: [PATCH] dmaengine: mv_xor: Add support for IO (PCIe) src/dst areas
In-Reply-To: <20160824144314.18928e13@free-electrons.com>
References: <201608241240.aEXnCS9C%fengguang.wu@intel.com>
 <b8c09619-22a5-a677-8841-9760c275a618@denx.de>
 <20160824144314.18928e13@free-electrons.com>
Message-ID: <940069ae-25eb-9106-ac41-300e1730d833@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24.08.2016 14:43, Thomas Petazzoni wrote:
> On Wed, 24 Aug 2016 10:23:02 +0200, Stefan Roese wrote:
>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/built-in.o: In function `set_param_ifnum':
>>>>> ipmi_poweroff.c:(.text+0x10157c): undefined reference to `mvebu_mbus_get_io_win_info'
>>>    drivers/built-in.o: In function `mv_xor_add_io_win':
>>>    mv_xor.c:(.text+0x11039e): undefined reference to `mvebu_mbus_get_io_win_info'
>>
>> Does it really make sense to compile this driver for all archs?
>> Or should I send a v2 of this patch that removes COMPILE_TEST for
>> this driver from Kconfig so that its only compiled for the
>> target platforms?
>
> I'm not sure what's the exact policy, but I believe kernel maintainers
> like when the compilation coverage is as wide as possible. The MBus
> driver could provide some stub functions when not enabled? I don't know
> if it's worth it, since indeed mv_xor is only ever going to be used on
> ARM.

As you've probably already noticed, v2 of this patch with
COMPILE_TEST removed also did run into this linking problem -
for ARM64 in this case. So its perhaps best to provide this MBus
driver stub function. COMPILE_TEST could then be enabled again.

What do you think? Should I post a separate patch to the MBus
driver (also attached)? Or should I squash it into v3 of this
XOR DMA driver patch (with COMPILE_TEST added gain)?

Thanks,
Stefan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-bus-mvebu-mbus-Provide-stub-function-for-mvebu_mbus_.patch
Type: text/x-diff
Size: 1834 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/7bb3708b/attachment.bin>
