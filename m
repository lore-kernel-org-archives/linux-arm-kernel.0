From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 28 Sep 2017 14:22:03 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Enable USB3503 driver
In-Reply-To: <20170928104351.GE6726@otheros>
References: <20170928024022.2071-1-linus.luessing@c0d3.blue>
 <CAJKOXPfQ3nXHVYXUn0iDfzVQc+ML1sSCz3NG_bwUw=WDK0id_w@mail.gmail.com>
 <20170928104351.GE6726@otheros>
Message-ID: <CAJKOXPeN+Rtseaz+szF6-QFqq2kRYPVEwy+t8NTqO6VyefUiJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 12:43 PM, Linus L?ssing
<linus.luessing@c0d3.blue> wrote:
> Hi Krzysztof,
>
> Thanks for your quick reply!
>
> On Thu, Sep 28, 2017 at 08:21:26AM +0200, Krzysztof Kozlowski wrote:
>> [...]
>> Anyway please define this as a module (unless it can't... but it
>> worked in my case).
>
> In that case you used an initrd, right? I see various cases of USB
> built-ins, like CONFIG_USB_STORAGE=y, CONFIG_USB_DWC2=y and so on in
> multi_v7_defconfig. So my impression was that multi_v7_defconfig was
> supposed to allow booting a rootfs from a USB storage device even
> without an initrd.

We use modules for multi_v7 as much as possible with that exception as
fair as I remember - no need of initramfs/initrd for boots. If this is
your intention, please mention this in commit message ("using usb3503
as builtin to provide boot from USB without initrd/initramfs").

Best regards,
Krzysztof
