From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Oct 2015 01:00:29 -0700
Subject: [PATCH v2] arm: omap2: timer: don't disable our timers
In-Reply-To: <1444092332-9011-1-git-send-email-balbi@ti.com>
References: <1444092332-9011-1-git-send-email-balbi@ti.com>
Message-ID: <20151006080028.GI23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [151005 17:49]:
> We actually want these devices to be created because
> we will be moving timers to drivers/clocksource and
> this will prevent them from probing.

Great. Is this safe to appy on it's own? We are not getting
system timers re-inited to the default values?

> The only situation where we want secure timers to be
> actually disabled is when we *know* we're running on
> non-GP (read: HS or EMU) chips, because the secure
> timer will NOT be available for the public world.

Yup.

Regards,

Tony
