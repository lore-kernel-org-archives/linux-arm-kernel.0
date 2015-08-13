From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Aug 2015 16:33:33 +0200
Subject: [PATCH v2 0/3] Have Tegra's GPIO chip depend explicitly on the
 pinctrl device
In-Reply-To: <1436862596-27730-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1436862596-27730-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150813143332.GC26559@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 10:29:53AM +0200, Tomeu Vizoso wrote:
> Hello,
> 
> these three patches make sure that there's an explicit dependency from
> the GPIO chip in Tegra SoCs to the corresponding pinctrl device, without
> having duplicated gpio ranges.
> 
> By having an explicit dependency, we can do things such as probing the
> pinctrl device before the GPIO chip device to avoid deferred probes.
> 
> Thanks,
> 
> Tomeu
> 
> Changes in v2:
> - Don't defer probe if the pinctrl node is disabled
> - Remove outdated comment from the commit changelog
> 
> Tomeu Vizoso (3):
>   gpio: defer probe if pinctrl cannot be found
>   pinctrl: tegra: Only set the gpio range if needed
>   ARM: tegra: Add gpio-ranges property

Patches 2 and 3 applied to the Tegra tree. Linus, I've applied the
pinctrl patch to a separate branch, so we could use that to resolve
conflicts, should there be any.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150813/d6be596e/attachment.sig>
