From: johan@kernel.org (Johan Hovold)
Date: Wed, 22 Oct 2014 12:18:49 +0200
Subject: [PATCH 09/12] rtc: omap: add support for pmic_power_en
In-Reply-To: <20141010180721.GV31348@saruman>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1412881594-25678-10-git-send-email-johan@kernel.org>
 <20141010180721.GV31348@saruman>
Message-ID: <20141022101849.GL2113@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 01:07:27PM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 09:06:31PM +0200, Johan Hovold wrote:

> > -	/* clear pending irqs, and set 1/second periodic,
> > -	 * which we'll use instead of update irqs
> > +	/*
> > +	 * disable interrupts
> > +	 *
> > +	 * NOTE: ALARM2 is not cleared on AM3352 if rtc_write (writeb) is used
> >  	 */
> > -	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
> > +	rtc_writel(0, OMAP_RTC_INTERRUPTS_REG);
> 
> bug fix, should be part of a separate patch and Cc stable :-)

I made this a separate fix in v2 but did not mark it for stable for now
as no one has been bitten by it (ALARM2 is never enabled by the current
driver).

Johan
