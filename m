From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 15 Sep 2015 15:50:23 +0900
Subject: [PATCH] ARM: multi_v7_defconfig: enable usb3503
In-Reply-To: <CAAqcGHmaWXFAVairN+2pw6adDG8AMc-MTMKp4g5aUP9Kw+8i7A@mail.gmail.com>
References: <1426254866-24772-1-git-send-email-riku.voipio@linaro.org>
 <556FF260.5060006@collabora.co.uk>
 <7hd21b2wo4.fsf@deeprootsystems.com> <4414616.t6CSY5FxHU@wuerfel>
 <CAAqcGHmaWXFAVairN+2pw6adDG8AMc-MTMKp4g5aUP9Kw+8i7A@mail.gmail.com>
Message-ID: <CAJKOXPcmeYowKkUkz9zYm31YJLpSQ4V40KeiiEOGdkZkPyX7iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-09-14 17:35 GMT+09:00 Riku Voipio <riku.voipio@linaro.org>:
> On 5 June 2015 at 15:45, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 04 June 2015 10:47:07 Kevin Hilman wrote:
>>>
>>> > But I wonder why is not working, shouldn't the driver defer and
>>> > be probed again once the PHY driver probe succeeds?
>>>
>>> Yeah, I'm not sure why that isn't working, and didn't look into it.
>>>
>>> FWIW, the same problem happens when both are modules.  If you modprobe
>>> usb3503 first, then the phy, it doesn't work.  You have to load the phy
>>> before the usb3503.
>
>> The driver does not try to get a reference to the phy, and it does
>> not return -EPROBE_DEFER in any circumstance, so I assume it just
>> runs into an error condition on the first probe and does not
>> try again.
>
>> I don't really understand why the driver registers both an i2c_driver
>> and a platform_driver, or if that is required, but it may also
>> complicate getting deferred probing to work here.
>
> Is someone looking into fixing it?

Fixing what? The PHY issue? The driver not supporting deferred probe?

As for module vs builtin, this is somehow orthogonal for me.
Although modules are preferred on multi_v7 but in case of
boot-essential drivers this should not be a requirement. I also don't
use initrd for network boot... however my root is on MMC. Regardless
if of that I would expect nfsroot to be working on multi_v7 kernel.

>From my point of view this is the same case as USB_NET_SMSC75XX or
USB_NET_SMSC95XX, so:
1. Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
2. +1 for CONFIG_PHY_SAMSUNG_USB2=y (regardless of fixing issues in the driver)
3. +1 for fixing the PHY driver


Best regards,
Krzysztof
