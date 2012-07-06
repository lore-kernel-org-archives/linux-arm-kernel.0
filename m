From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 08:22:56 +0800
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120705182829.d13d6992406e02e1024552e3@freescale.com>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
Message-ID: <20120706002254.GB20175@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 06:28:29PM -0500, Kim Phillips wrote:
> On Wed, 4 Jul 2012 23:38:14 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > +static const struct of_device_id __devinitconst snvs_dt_ids[] = {
> > +	{ .compatible = "fsl,sec-v4.0-mon-rtc-lp", },
> 
> the driver should be compatible with "fsl,sec-v4.0-mon", and its
> probe function search for "fsl,sec-v4.0-mon-rtc-lp" sub-compatibles
> (and possibly "fsl,sec-v4.0-mon-rtc-hp" in the future?).
> 
So you think snvs is all about rtc (lp and hp), nothing else?  If that
is true, it's reasonable to do what you suggested here.  Otherwise, we
should have a snvs driver be compatible with "fsl,sec-v4.0-mon", and
this driver should be responsible for populate all the sub-devices of
snvs, rtc-lp, rtc-hp, and others.  In the latter case, rtc-snvs should
just stay as it stands right now.

-- 
Regards,
Shawn
