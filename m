From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 09 Jul 2014 12:13:41 +0300
Subject: [PATCH] Input: s3c2410_ts: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <20140709010049.GC14935@core.coreip.homeip.net>
References: <1404155377-2862-1-git-send-email-anarsoul@gmail.com>
 <20140709010049.GC14935@core.coreip.homeip.net>
Message-ID: <2138540.gOK28iFQ6r@vasilykh-desktop-i5>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 18:00:49 Dmitry Torokhov wrote:

Hi Dmitry,

> > 
> > -	clk_disable(ts.clock);
> > +	clk_disable_unprepare(ts.clock);
> 
> Do we really need to unprepare on suspend? Why simply disabling is not
> enough here?

You're right, disabling should be enough here. I'll resend a patch after 
testing on a hardware.

Regards
Vasily
