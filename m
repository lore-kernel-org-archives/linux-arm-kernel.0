From: davidm@egauge.net (David Mosberger)
Date: Mon, 25 Jan 2016 09:24:04 -0700
Subject: [PATCH] misc: atmel-secumod: Driver for Atmel "security module".
In-Reply-To: <20160125110921.GA4027@piout.net>
References: <1453348655-31182-1-git-send-email-davidm@egauge.net>
 <20160125110921.GA4027@piout.net>
Message-ID: <CALnQHM13cGnoma_3erb0oCnRD0sYGGNF1E1cgzCJHrEXbvJpRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

On Mon, Jan 25, 2016 at 4:09 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> I know this does more than that but I think those thre sections should
> be registered using the nvmem framework. The sysfs file creation and
> accesses then comes for free.

I think Finn's patches would have to go in for that first, since the
existing nvram code is a mess.
Even with Finn's patches in, I think it could go either way.  I'm not
exactly sure how some of the
features of the security module would be used: key management, auto
erasing, there is a strange
"backup mode" vs "normal mode" which is not well documented, etc.  So
I think it may well end up
being sufficiently different to warrant a separate driver.

> Another idea is also to expose it using a genpool so it can be accessed
> as sram from inside the kernel.

That may be a fine idea, but as far as our application is concerned,
we need user-level access
to the battery-backed RAM.

Best regards,

  --david
-- 
eGauge Systems LLC, http://egauge.net/, 1.877-EGAUGE1, fax 720.545.9768
