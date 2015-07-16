From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Jul 2015 16:15:16 +0200
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <20150716125529.GG4039@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl> <20150716125529.GG4039@sirena.org.uk>
Message-ID: <1437056116.28351.19.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On do, 2015-07-16 at 13:55 +0100, Mark Brown wrote:
> No, in that case you've not understood what the MODULE_ALIAS is
> for.  It's there so that userspace knows which module to load if it 
> gets
> a device with no driver, it goes in the driver not in the code
> registering the device.

That's exactly how I understood MODULE_ALIAS() to work.

And it works, in short, because a platform device fires a
"MODALIAS=platform:[...]" uevent when it's created. And userspace uses
that uevent to load the module carrying that alias.

Let's put it this was. If one does
    sudo find /sys -perm -o=r -name uevent -exec grep -H MODALIAS=platform: {} \;

or
    sudo find /sys -perm -o=r -name modalias -exec grep -H platform: {} \;

(both lists should be similar)

on the systems this patch is targeting, will
   platform:rockchip-snd-max98090

then show up?

Thanks,


Paul Bolle
