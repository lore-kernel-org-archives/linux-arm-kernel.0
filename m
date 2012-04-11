From: cjb@laptop.org (Chris Ball)
Date: Wed, 11 Apr 2012 12:58:58 -0400
Subject: [PATCH] mmc: remove linux/blkdev.h include from host drivers
In-Reply-To: <20120411165223.GP3852@pengutronix.de> (Sascha Hauer's message of
 "Wed, 11 Apr 2012 18:52:23 +0200")
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
 <87ty0qs2fz.fsf@laptop.org> <20120411165223.GP3852@pengutronix.de>
Message-ID: <87pqberyr1.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 11 2012, Sascha Hauer wrote:
>> Should imxmmc simply be removed from drivers/mmc/host?  Do any of the
>> more current i.MX MMC drivers support the same hardware?
>
> It has long been on my todo list to remove this driver. The more recent
> i.MX use the mxcmmc driver which is basically the same hardware but
> without a bunch of bugs which made the older imxmmc driver unusable on
> newer hardware. I can send a patch if you like.

Thanks, let's do it.

It would be nice to have a story for how MX1 users can use their
hardware with modern kernels, even if it's just "It should be possible
to modify the mxcmmc driver to support this older hardware, and the sort
of changes that need to be made are <..>".

(Dmitry, your patch is fine -- I can remove the imxmmc hunk from it when
applying.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
