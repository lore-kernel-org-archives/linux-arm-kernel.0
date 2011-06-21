From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 21 Jun 2011 11:44:00 +0200
Subject: [PATCH v3 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
In-Reply-To: <20110621013905.GB6294@S2101-09.ap.freescale.net> (Shawn Guo's
	message of "Tue, 21 Jun 2011 09:39:06 +0800")
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<20110621013905.GB6294@S2101-09.ap.freescale.net>
Message-ID: <87oc1ra59b.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@freescale.com> writes:

> Hi Arnaud,

Hi,

>
> Would you please give a test on the series, as it fixed the issue
> you reported?  TIA.

I've tested it yesterday on my efika platforms and the issue is
gone. Moreover, the differents card slot on theses platforms are using
each card detect type (internally connected, gpio, no card detect) and
they are all working as expected. I'm a little bit annoyed by the
polling on the slot without card detect but this has nothing to do with
this patchset.

Side note: turns out that the driver is using dev_warn when failing to
get cd gpio/irq. Given that in theses cases, it jumps to
no_card_detect_pin and makes the probe fail, maybe a dev_err would be
better ? 

Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Thanks,
Arnaud
