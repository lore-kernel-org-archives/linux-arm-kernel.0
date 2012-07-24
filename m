From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 15:01:47 +0000
Subject: [PATCH v2 00/25] make *struct of_device_id.data const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201207241501.48302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 July 2012, Uwe Kleine-K?nig wrote:
> this is the 2nd version of this series whose goal is to make struct
> of_device_id.data const. Conceptually a driver must not modify the data
> contained there so making it const is the right thing.
> 
> v1 of this series was sent with Message-id:
> 1342182734-321-1-git-send-email-y. Changes since then are:
>  - powerpc fixes
>  - several new consts that were found by Arnd that are possible after
>    patch 19.
>    
> Arnd suggested to take this series via arm-soc late for 3.6 in one go
> because patch 19 depends on the former patches but is a precondition to
> the latter and it fixes a few warnings. So getting it in via the
> respective maintainer trees would need a much bigger coordination
> effort. That means I prefer getting Acks over you taking the patch.
> 
> Vinod Koul already took
>         dmaengine: at_hdmac: add a few const qualifiers
> that is in next-20120723 as 7fd63ccdad72 now. Vinod, I don't follow your
> pull requests, but assuming you didn't let it already pull for 3.6 I
> suggest you drop it from your queue and I just take your Ack.
> 
> This series was build tested for arm (all defconfigs) and powerpc (all
> defconfigs and an allyesconfig) and grep didn't find more issues. As
> before it introduces a warning in drivers/regulator/twl-regulator.c.
> This driver does modify its .of_match_table when a device is bound which
> doesn't fits the concept of independant devices. Arnd noticed another
> new warning in drivers/scsi/qlogicpti.c that isn't that easy to resolve,
> because the pointer to (now) const data is passed as first argument to
> scsi_host_alloc. To fix that properly struct Scsi_Host.hostt needs to
> get a const, too. Alternatively I could introduce a cast removing the
> const, but I don't like that.
> 
> This series is also available at:
> 
>         git://git.pengutronix.de/git/ukl/linux.git ofdeviceiddata
> 
> and I will modify it there for the Acks I'm getting.

Pulled the entire series into arm-soc/late/warnings. Thanks everyone
who provided Acks. I'll wait for a few more days to let this sit
in linux-next and if nobody complains, Olof or I will forward it
to Linus.

	Arnd
