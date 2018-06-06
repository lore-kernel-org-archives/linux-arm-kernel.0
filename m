From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 6 Jun 2018 14:26:22 -0400
Subject: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20180606142600.GN13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
Message-ID: <20180606142622.2338abf6@vmware.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jun 2018 16:26:00 +0200
Johan Hovold <johan@kernel.org> wrote:

> Looks like the greybus code above is working as intended by checking for
> unterminated string after the strncpy, even if this does now triggers
> the truncation warning.

Ah, yes I now see that. Thanks for pointing it out. But perhaps it
should also add the "- 1" to the strncpy() so that gcc doesn't think
it's a mistake.

-- Steve
