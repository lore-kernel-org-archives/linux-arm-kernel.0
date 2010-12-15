From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 15 Dec 2010 15:29:56 +0100
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	(Sascha Hauer's message of "Wed, 15 Dec 2010 15:01:29 +0100")
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87y67rcdnf.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi,

Hi,

>
> The following series picks up the patch from Lothar Wa?mann replacing
> the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
> support based on this patch.
> The iomux configurations are taken from the Freescale pinmux tool, so the
> definitions should be rather complete. Anyway, there are some modes
> not present in the tool.
> I took the padmux settings from the old iomux support where present.

I'm seeing a lot of changes in the iomux file and I have a patch [1]
setting the SION bit for all gpios configuration so that reading the PSR
value is giving usefull results when the gpio is configured as output. I
wanted to send it this week but it will obviously conflict with
this. Should I test your patchset first and if it's working, wait
for its merge or should I send it anyway ? How do you want to deal with
this (as long as you're fine with setting the SION bit for all gpios) ?

Thanks,
Arnaud

[1] http://git.rtp-net.org/?p=efika.git;a=blob;f=mx51_gpiolib_out_value.patch;h=62d4db72c1021f8cb756a728390dbab2ca02c44a;hb=HEAD
