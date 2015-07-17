From: zhengxing@rock-chips.com (zhengxing)
Date: Fri, 17 Jul 2015 10:17:25 +0800
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <1437056116.28351.19.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl> <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl> <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
Message-ID: <55A865B5.7020609@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On 2015?07?16? 22:15, Paul Bolle wrote:
>
> That's exactly how I understood MODULE_ALIAS() to work.
>
> And it works, in short, because a platform device fires a
> "MODALIAS=platform:[...]" uevent when it's created. And userspace uses
> that uevent to load the module carrying that alias.
>
> Let's put it this was. If one does
>      sudo find /sys -perm -o=r -name uevent -exec grep -H MODALIAS=platform: {} \;
>
> or
>      sudo find /sys -perm -o=r -name modalias -exec grep -H platform: {} \;
>
> (both lists should be similar)
>
> on the systems this patch is targeting, will
>     platform:rockchip-snd-max98090
>
> then show up?
>
> Thanks,
>
>
> Paul Bolle
>
Thank you for your patience and detailed explanation.
I tested your two ways and didn't find the 
"platform:rockchip-snd-max98090" in my device(kernel v3.14), and the 
driver path is:
localhost rockchip-snd-max98090 # pwd
/sys/bus/platform/drivers/rockchip-snd-max98090

Thanks.
