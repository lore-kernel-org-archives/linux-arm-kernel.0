From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 11 May 2015 13:25:14 +0200
Subject: [PATCH] ARM: exynos_defconfig: add options to make wifi usable
In-Reply-To: <20150511105034.40580.qmail@dec59.ruk.cuni.cz>
References: <20150511105034.40580.qmail@dec59.ruk.cuni.cz>
Message-ID: <5550919A.9090703@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Michal,

On 05/11/2015 12:22 PM, Michal Suchanek wrote:
> The Exynos defconfig includes mwifiex sdio support which is present on
> some of the Exynos boards.
> 
> For the WiFi to be usable two extra options are needed. Usermode

Your subject line and the commit message are somehow misleading since
these options are needed to make the WiFi usable with your current setup.

> firmware helper to load out-of-kernel firmware and wireless extensions

For example, this is only needed if the in-kernel fw loader is not
able to find the firmware but isn't needed if the fw is for example
in an initial ramdisk and the kernel is able to load it, built in the
kernel or if the mwifiex driver is built as a module.

> so the interface can be configured with wireless-tools.
>

And wireless extensions is deprecated AFAIK and is only needed for old
user-space since most tools should had been converted to use the netlink
based CONFIG_CFG80211 interface instead.

I'm booting a debian jessie and have WiFi working without CFG80211_WEXT
for example.

That doesn't mean that I'm against your patch (I'm always happy to enable
more config options if that makes the defconfig more useful) but the commit
message should be accurate about why a change has to be done.

> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---

Best regards,
Javier
