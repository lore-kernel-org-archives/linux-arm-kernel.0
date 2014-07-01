From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 30 Jun 2014 21:11:55 -0400
Subject: [PATCH] clk: Add tracepoints for hardware operations
In-Reply-To: <53B209E5.1050701@codeaurora.org>
References: <1404172599-10171-1-git-send-email-sboyd@codeaurora.org>
 <20140630205211.3d114169@gandalf.local.home>
 <53B209E5.1050701@codeaurora.org>
Message-ID: <20140630211155.18fbffc8@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jun 2014 18:07:49 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> >
> >>  		if (clk->ops->enable) {
> >>  			ret = clk->ops->enable(clk->hw);
> >>  			if (ret) {
> >> @@ -945,6 +965,7 @@ static int __clk_enable(struct clk *clk)
> >>  				return ret;
> > It may make even more sense to add the tracepoints within the if
> > statement. Especially if you have a return on error.
> >
> >
> 
> Right. I was thinking that no "clk*_complete" event would mean there was
> some error. Detecting that case is not so easy though. It may be better
> to always have the completion event so we know how long hardware
> operations take and so that error handling is simpler.
> 

You could also have the event record the ret as well.

-- Steve
