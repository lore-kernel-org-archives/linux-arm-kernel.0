From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 11:38:41 +0000
Subject: [RFC v4 13/26] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <20180212105456.3zejp3j7hfuzyc3c@ninjato>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-14-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180207230309.goxig2irkpxrw5el@katana>
 <TY1PR06MB089578618AA33335D90D16CEC0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20180212105456.3zejp3j7hfuzyc3c@ninjato>
Message-ID: <TY1PR06MB08958A4A75A0F3BB2BF1D086C0F70@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > I used to have this simpler version (back then for the UP case):
> > >
> > > +rwdt_start(wdev);
> > > +rwdt_write(priv, 0xffff, RWTCNT);
> > > +return 0;
> > >
> > > It should still work probably...
> >
> > It should still work, but it would be slower, I would stick with the
> > version I have submitted if you don't mind.
>
> Actually, I do mind. Because of code duplication reasons. We have a fix
> in the works for rwdt_start() and it would be too easy to overlook the
> same fix will be needed for a restart.

The code is very similar indeed, but not exactly duplicated as it sets the registers in order to reset
the system as quickly as possible.
But since you have strong feelings about this I'll reuse this other version for the next submission.

Thanks,
Fabrizio




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
