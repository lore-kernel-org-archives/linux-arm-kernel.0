From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 22 Jul 2014 23:09:14 -0700
Subject: [PATCH] Input: s3c2410_ts: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <2138540.gOK28iFQ6r@vasilykh-desktop-i5>
References: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
 <20140709010049.GC14935@core.coreip.homeip.net>
 <2138540.gOK28iFQ6r@vasilykh-desktop-i5>
Message-ID: <20140723060913.GD25004@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasily,

On Wed, Jul 09, 2014 at 12:13:41PM +0300, Vasily Khoruzhick wrote:
> On 8 July 2014 18:00:49 Dmitry Torokhov wrote:
> 
> Hi Dmitry,
> 
> > > 
> > > -	clk_disable(ts.clock);
> > > +	clk_disable_unprepare(ts.clock);
> > 
> > Do we really need to unprepare on suspend? Why simply disabling is not
> > enough here?
> 
> You're right, disabling should be enough here. I'll resend a patch after 
> testing on a hardware.

I ended up cutting out suspend/resume parts and applying.

Thanks.

-- 
Dmitry
