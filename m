From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 23 Jul 2014 10:59:36 +0300
Subject: [PATCH] Input: s3c2410_ts: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <20140723060913.GD25004@core.coreip.homeip.net>
References: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
 <2138540.gOK28iFQ6r@vasilykh-desktop-i5>
 <20140723060913.GD25004@core.coreip.homeip.net>
Message-ID: <2335676.R6Ieja8iHY@vasilykh-desktop-i5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2014 23:09:14 Dmitry Torokhov wrote:
> Hi Vasily,
> 
> On Wed, Jul 09, 2014 at 12:13:41PM +0300, Vasily Khoruzhick wrote:
> > On 8 July 2014 18:00:49 Dmitry Torokhov wrote:
> > 
> > Hi Dmitry,
> > 
> > > > -	clk_disable(ts.clock);
> > > > +	clk_disable_unprepare(ts.clock);
> > > 
> > > Do we really need to unprepare on suspend? Why simply disabling is not
> > > enough here?
> > 
> > You're right, disabling should be enough here. I'll resend a patch after
> > testing on a hardware.
> 
> I ended up cutting out suspend/resume parts and applying.

Ah, I was about to send v2. I've tested a version with clk_disable/clk_enable 
in suspend/resume parts, and it works OK for me.

Thanks!

Regards,
Vasily

> 
> Thanks.
