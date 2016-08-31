From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 31 Aug 2016 11:30:36 +0100
Subject: [PATCH v3] Added perf functionality to mmdc driver
In-Reply-To: <DB5PR04MB1430D8A0284123B5C475800E9FE00@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <20160817194253.16300-1-zhengyu.shen@nxp.com>
 <CAHrpEqTtCnEU1v1sEuN8yJGPudDRZ5A79=Wn5Bp4SgTxDiNTQQ@mail.gmail.com>
 <20160830114329.GB8366@tiger> <20160830125420.GG1223@leverpostej>
 <DB5PR04MB1430D8A0284123B5C475800E9FE00@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <20160831102937.GC4783@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 08:01:18PM +0000, Zhengyu Shen wrote:
> Hi, I've done some testing with the fuzzer.

Great! Many thanks for doing this.

> Mmdc was only responsible for one crash which I fixed (had to remove
> the event from the pmu properly). 

Ok. I take it that there will be a v4 appearing shortly with that fix?

> Other drivers also cause crashes and the program reports that events are
> Throttling. Is this normal?

Throttling is normal, and warnings about throttling can (generally) be
safely ignored.

Crashes are very bad. Do you have any logs from those crashes in other
drivers that you can share?

It is possible that a bug in one driver causes failures in another (e.g.
if events are erroneously grouped together), so it's not alwyas clear if
this is an unrelated bug (though if you can trigger the issue without
your driver present, it clearly is).

Thanks,
Mark.
