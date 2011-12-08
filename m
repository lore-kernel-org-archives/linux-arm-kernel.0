From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Dec 2011 12:43:36 -0700 (MST)
Subject: [PATCH] arm: omap: rm-680: fix the panic during boot
In-Reply-To: <1322850650-13171-1-git-send-email-aaro.koskinen@nokia.com>
References: <1322850650-13171-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <alpine.DEB.2.00.1112081243100.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2011, Aaro Koskinen wrote:

> Booting the Linux kernel on Nokia RM-680 board has been broken since
> 2.6.39 due to the following:
> 
> [    0.217193] omap_hwmod: timer12: enabling
> [    0.221435] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa304010

...

> Timer 12 is not necessarily available on non-GP devices (see e.g.
> http://marc.info/?l=linux-omap&m=129433066521102&w=2), so it should be
> registered only on GP OMAPs. With this change it's again possible to
> boot RM-680 into the shell. Tested with 3.2-rc4.

Thanks, tweaked the subject line a little and queued for 3.2-rc.


- Paul
