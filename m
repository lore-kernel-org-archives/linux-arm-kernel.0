From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jul 2013 00:22:45 -0700
Subject: [PATCH 0/2] Fix omap serial early crash during hwmod _setup()
In-Reply-To: <1373539986-27272-1-git-send-email-rnayak@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
Message-ID: <20130712072244.GB7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130711 03:59]:
> This series should fix the issue with the early serial crash seen
> during hwmod _setup() as reported by [1]
> 
> The issue was reported on a am33xx device and was not seen on omap4
> or omap5 devices as the hwmod data for both omap4 and omap5 had
> statically defined HWMOD_INIT_NO_IDLE and HWMOD_INIT_NO_RESET for
> uart3 which happens to be the debug console used on omap4 panda and
> omap5 uevm boards.

The serial driver should be capable of setting this on it's own
as it sets up the console.

Regards,

Tony
