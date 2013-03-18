From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 18 Mar 2013 12:33:04 +0100
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <201303181116.17369.arnd@arndb.de>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
 <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
 <201303181116.17369.arnd@arndb.de>
Message-ID: <5146FB70.9000706@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/18/13 12:16, Arnd Bergmann a ?crit :
> On Monday 18 March 2013, Jonas Jensen wrote:
>>
>> On 15 March 2013 13:49, Florian Fainelli <florian@openwrt.org> wrote:
>>> Someone recently announced support for a Moxart SoC which seems to use the
>>> FA526 core however.
>>
>> That was probably me, and I understand people want it gone. Even
>> Debian wants v4:s gone because they're not strictly EABI (
>> http://lists.debian.org/debian-arm/2010/12/msg00044.html ).
>
> It's not that we want it gone, it si that we want unmaintained code
> to be removed. ARMv4 support is going to stay at least for a couple
> more years, probably longer given the number of ARM7TDMI and StrongARM
> systems still in use.
>
> There are probably no general purpose distros that will build for
> ARMv4 any more, but a lot of the embedded distros (OpenWRT, OpenEmbedded,
> Buildroot, ...) typically build all user space from source anyway, so
> there is no issue.

Debian is still kind enough to provide an ARMv4t and higher port 
(ArmEabi) though I am not sure how long this is going to stay that way.

>
>> The port is not near mainline but I think I'd prefer if CPU_FA526
>> wasn't removed. If someone stepped up to maintain ARCH_GEMINI (so I
>> could peek at the changes) that would be even better :)
>
> I've tried before to find someone who is still interested in Gemini,
> but it seems nobody has the hardware any more.

Imre Kaloz is supposed to have some, if you want to get some hardware 
yourself it seems that the mainline boards (WBD111, WBD222, NAS4420) are 
the only hardware devices that OpenWrt also supports. The OpenWrt 
patches we have add support for Ethernet, watchdog, USB, PCI, but have 
not been submitted mainline.

>
> My plan right now is to leave CPU_FA526 alone but drop ARCH_GEMINI
> in 3.10. We can revisit the situation next year. If we don't hear back
> from you or someone else interested in this CPU type by then, we can
> still drop it then. It's not a maintainance burden anyway, the CPU
> specific code is well isolated and does not change a lot, compare
> to platform specific code.

Sounds good.
--
Florian
