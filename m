From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 22 Apr 2015 01:46:50 +0200
Subject: [rtc-linux] [PATCH 2/5] RTC/i.MX/DryIce: add the unit recovery
 code
In-Reply-To: <20150421231411.GC8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-3-git-send-email-jbe@pengutronix.de>
 <20150421231411.GC8539@piout.net>
Message-ID: <20150421234649.GG8539@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/2015 at 01:14:11 +0200, Alexandre Belloni wrote :
> > +	sec = __raw_readl(imxdi->ioaddr + DTCMR);
> > +	if (sec != 0)
> > +		dev_warn(&imxdi->pdev->dev,
> > +			"The security violation has happend at %u seconds\n",
> 
> Further improvement for this driver: use both DTCMR and DTCLR to be year
> 2038 proof

Please forget that comment I just realized that seconds were counted in
the most significant part...


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
