From: roger.lu@mediatek.com (Roger Lu)
Date: Wed, 29 Jun 2016 11:54:11 +0800
Subject: [PATCH] PM / suspend: show workqueues busy name in suspend flow
In-Reply-To: <20160628165616.GD5185@htj.duckdns.org>
References: <1466586509-32400-1-git-send-email-roger.lu@mediatek.com>
 <20160622152126.GV3262@mtj.duckdns.org>
 <1467020645.25092.24.camel@mtksdaap41>
 <20160628165616.GD5185@htj.duckdns.org>
Message-ID: <1467172451.4141.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Tejun,

On Tue, 2016-06-28 at 12:56 -0400, Tejun Heo wrote:
> Hello, Roger.
> 
> On Mon, Jun 27, 2016 at 05:44:05PM +0800, Roger Lu wrote:
> > show_workqueue_state() is a better choice to me. However, only freezable
> > workqueue is able to affect suspend flow. So, is there other mailing
> > list discussing about showing freezable workqueue state only?? Maybe we
> > can use that API in this case. Thanks very much.
> > 
> > freezable workqueue means workqueue is created with flag WQ_FREEZABLE.
> 
> It's for debugging anyway and workqueue dumps usually are pretty
> short.  I don't think it's fine to use the same function.  We can add
> flags in the printouts but I'm not even sure that'd be necessary.
> 
> Thanks.
> 

Please allow me to elaborate my previous concern about printing
freezable workqueue info only in this case.

The benefit of it is that debugger can quickly understand which
freezable workqueues block suspend flow and assign this issue to
corresponding owner instead of extracting freezable workqueue info from
show_workqueue_state() first and, then, assigning the issue.

Adding a flag to printout the info we need is great. Perhaps we can do
that. Thanks for the advice.

Sincerely,
Roger Lu.
