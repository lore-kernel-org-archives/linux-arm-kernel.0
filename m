From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 16 Jul 2015 18:22:45 +0200
Subject: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
In-Reply-To: <20150716150500.GO4039@sirena.org.uk>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <1437033944.27428.11.camel@tiscali.nl>
 <20150716110032.GU11162@sirena.org.uk>
 <1437047261.28351.6.camel@tiscali.nl> <20150716125529.GG4039@sirena.org.uk>
 <1437056116.28351.19.camel@tiscali.nl>
 <20150716150500.GO4039@sirena.org.uk>
Message-ID: <1437063765.21215.18.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On do, 2015-07-16 at 16:05 +0100, Mark Brown wrote:
> Why would this not be the case - what is the difference you beleive
> this driver has to other platform drivers?

It's my believe that for MODULE_ALIAS("platform:[...]") to be useful
there needs to be corresponding struct platform_device. For this patch
that would be a platform device named "rockchip-snd-max98090". (This is
something that I try to check rather carefully, because these devices
can be generated on the fly.)

I'm happy to drop this believe if someone shows me another way that
MODULE_ALIAS("platform:[...]") can actually be used.

So, in short, the difference between this driver and other platform
drivers is that, as far as I'm aware, this platform driver lacks a
corresponding platform device. Probably because OF support suffices to
get this module autoloaded.

Thanks,


Paul Bolle
