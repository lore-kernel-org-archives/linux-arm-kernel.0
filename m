From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 14 Jun 2011 16:29:57 +0200
Subject: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
	support for mx5
In-Reply-To: <20110614113902.GD30295@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Tue, 14 Jun 2011 19:39:03 +0800")
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<20110614064841.GB30295@S2100-06.ap.freescale.net>
	<87ei2wk6na.fsf@lebrac.rtp-net.org>
	<20110614113902.GD30295@S2100-06.ap.freescale.net>
Message-ID: <87lix4iize.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@freescale.com> writes:

> On Tue, Jun 14, 2011 at 01:13:29PM +0200, Arnaud Patard wrote:
>> Shawn Guo <shawn.guo@freescale.com> writes:
>> 
>> Hi,
>> 
>> > On Fri, Jun 10, 2011 at 06:42:48PM +0800, Shawn Guo wrote:
>> >> The card-present polling within sdhci based driver is very expensive
>> >> in terms of the impact to system performance.  We observe a few
>> >> system performance issues from Freescale and Linaro on mx5 platforms,
>> >> which have been proved card polling related.
>> >> 
>> >> The patch set extends the current sdhci-esdhc-imx card_detect and
>> >> write_protect support to cover mx5 platforms, and solves above
>> >> performance issues.
>> >> 
>> >> Shawn Guo (4):
>> >>       mmc: sdhci: fix interrupt storm from card detection
>> >>       mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
>> >>       mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
>> >>       mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
>> >> 
>> > Hi Arnaud,
>> >
>> > Any chance to play with it yet?
>> 
>> I tried applying the patch 4 (v2) on mmc git and Sascha Hauer's for-next
>> branch and failed. Can you please tell me on which tree should I apply
>> it ?
>> 
> Sascha really should not picked up the following 3 patches.  They are
> nonsense when driver is not even ready for the support.  These 3
> patches have conflict with my patch set.  You should be able to
> apply with these 3 removed.

They're still not applying. It's failing to failing
sdhci-esdhc-imx.c. I'm currently trying t make sure I didn't miss
something but it looks like the patch is not against for-next. For
instance, look at :
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=blob;f=drivers/mmc/host/sdhci-esdhc-imx.c;h=a19967d0bfc48b0ce8216de0d1a727093ee9fa03;hb=refs/heads/for-next

It's already adding a esdhc_pltfm_get_ro() function, so I fail to see
how a patch adding a function with same name can work.

Thanks,
Arnaud
