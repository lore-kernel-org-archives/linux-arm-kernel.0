From: davidm@egauge.net (David Mosberger)
Date: Mon, 25 Jan 2016 09:17:55 -0700
Subject: [PATCH] drivers: power: reset: at91-reset: Provide reset reason
 via sysfs (amended with Signed-off-by tag)
In-Reply-To: <20160125085539.GB16261@piout.net>
References: <1453394936-16616-1-git-send-email-davidm@egauge.net>
 <20160125085539.GB16261@piout.net>
Message-ID: <CALnQHM2vwhKPkrOABV9idrMrWync-Hi7MdZ_dEyEOEp3_k77yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

Thanks for taking a look at the patch.

On Mon, Jan 25, 2016 at 1:55 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> All sysfs files have to be documented. Can you add some documentation in
> Documentation/ABI ?

I'm not familiar with out this is organized and what file this would
have to be added to.  Other than that, sure I'd be happy to write
something up.

> Also, I think this should be added as a generic file for the whole subsystem.

A patch that shows what you have in mind would be helpful here.

>> -     pr_info("AT91: Starting after %s\n", reason);

You must have missed:

>> +     pr_info("AT91: Starting after %s\n", at91_reset_reason(pdev));

Best regards,

  --david
-- 
eGauge Systems LLC, http://egauge.net/, 1.877-EGAUGE1, fax 720.545.9768
