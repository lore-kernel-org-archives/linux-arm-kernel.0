From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 21 Jun 2011 22:12:25 +0800
Subject: [PATCH v3 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
In-Reply-To: <87oc1ra59b.fsf@lebrac.rtp-net.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<20110621013905.GB6294@S2101-09.ap.freescale.net>
	<87oc1ra59b.fsf@lebrac.rtp-net.org>
Message-ID: <20110621141223.GD9228@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 11:44:00AM +0200, Arnaud Patard wrote:
> Shawn Guo <shawn.guo@freescale.com> writes:
> 
> > Hi Arnaud,
> 
> Hi,
> 
> >
> > Would you please give a test on the series, as it fixed the issue
> > you reported?  TIA.
> 
> I've tested it yesterday on my efika platforms and the issue is
> gone. Moreover, the differents card slot on theses platforms are using
> each card detect type (internally connected, gpio, no card detect) and
> they are all working as expected. I'm a little bit annoyed by the
> polling on the slot without card detect but this has nothing to do with
> this patchset.
> 
That's great.

> Side note: turns out that the driver is using dev_warn when failing to
> get cd gpio/irq. Given that in theses cases, it jumps to
> no_card_detect_pin and makes the probe fail, maybe a dev_err would be
> better ? 
> 
Though it's the existing code, I respect the comment and will make the
change in the v4.

> Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 
Thanks for testing.

-- 
Regards,
Shawn
