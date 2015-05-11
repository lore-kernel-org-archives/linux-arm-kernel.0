From: hramrach@gmail.com (Michal Suchanek)
Date: Mon, 11 May 2015 14:23:09 +0200
Subject: [PATCH] ARM: exynos_defconfig: add options to make wifi usable
In-Reply-To: <5550919A.9090703@collabora.co.uk>
References: <20150511105034.40580.qmail@dec59.ruk.cuni.cz>
 <5550919A.9090703@collabora.co.uk>
Message-ID: <CAOMqctTDwwbacrLZ8iS_VZKNTBayEfaSX-s50ekcuGE4E=eNfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 May 2015 at 13:25, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Michal,
>
> On 05/11/2015 12:22 PM, Michal Suchanek wrote:
>> The Exynos defconfig includes mwifiex sdio support which is present on
>> some of the Exynos boards.
>>
>> For the WiFi to be usable two extra options are needed. Usermode
>
> Your subject line and the commit message are somehow misleading since
> these options are needed to make the WiFi usable with your current setup.
>
>> firmware helper to load out-of-kernel firmware and wireless extensions
>
> For example, this is only needed if the in-kernel fw loader is not
> able to find the firmware but isn't needed if the fw is for example
> in an initial ramdisk and the kernel is able to load it, built in the
> kernel or if the mwifiex driver is built as a module.

I am not sure how is including the firmware in a ramdisk going to
improve things over including it in my root filesystem. As far as I am
aware it does not make any difference for the kernel.

The firmware is not included in the kernel tree nor configured as
extra firmware option in the defconfig, either. Otherwise the firmware
loader would supposedly find the firmware and we would not have this
discussion.

The mwifiex driver is configured as built-in in the defconfig so what
happens when the driver is built as a module is not relevant for this
defconfig.

>
>> so the interface can be configured with wireless-tools.
>>
>
> And wireless extensions is deprecated AFAIK and is only needed for old
> user-space since most tools should had been converted to use the netlink
> based CONFIG_CFG80211 interface instead.
>
> I'm booting a debian jessie and have WiFi working without CFG80211_WEXT
> for example.

I'm booting Debian Jessie as well and for me WiFi is not working
without CFG80211_WEXT for another example.

So it might be that some tools have migrated to another interface but
at first glance I have no idea what those tools might be in Debian so
for me the WiFi is unusable without wireless extensions.

>
> That doesn't mean that I'm against your patch (I'm always happy to enable
> more config options if that makes the defconfig more useful) but the commit
> message should be accurate about why a change has to be done.

Do you have some specific suggestions about improvements to the commit message?

Thanks

Michal
