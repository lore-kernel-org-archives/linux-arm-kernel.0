From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 19 Mar 2013 10:00:54 +0100
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <5146FB70.9000706@openwrt.org>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
 <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
 <201303181116.17369.arnd@arndb.de> <5146FB70.9000706@openwrt.org>
Message-ID: <op.wt6rbsvq2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 18 Mar 2013 12:33:04 +0100, Florian Fainelli <florian@openwrt.org> wrote:

> Le 03/18/13 12:16, Arnd Bergmann a ?crit :
>> On Monday 18 March 2013, Jonas Jensen wrote:
>>>

<snip>

>>> The port is not near mainline but I think I'd prefer if CPU_FA526
>>> wasn't removed. If someone stepped up to maintain ARCH_GEMINI (so I
>>> could peek at the changes) that would be even better :)
>>
>> I've tried before to find someone who is still interested in Gemini,
>> but it seems nobody has the hardware any more.
>
> Imre Kaloz is supposed to have some, if you want to get some hardware
> yourself it seems that the mainline boards (WBD111, WBD222, NAS4420) are
> the only hardware devices that OpenWrt also supports. The OpenWrt
> patches we have add support for Ethernet, watchdog, USB, PCI, but have
> not been submitted mainline.

I have two wbd111 boards, but their bootloader is fubared - for whatever reason the bootloader's ethernet support works horribly for me, as in an image transfer takes well over 10 mins, and 90% of the time it fails meantime. I have another gemini based board, which doesn't have mainline support, yet.

So for gemini, what I can offer is digging up the wbd111 and testing your patches this weekend - if that works, it can stay in mainline for another kernel release, and I can try to add support for the other board (so there would be a sane platform to test on). If you are going to drop it, I will likely keep it working in OpenWrt as long as those boards don't die on me.


Imre
