From: jason.wessel@windriver.com (Jason Wessel)
Date: Mon, 30 Jul 2012 22:53:04 -0500
Subject: [PATCH 01/11] kernel/debug: Make use of KGDB_REASON_NMI
In-Reply-To: <1343649500-18491-1-git-send-email-anton.vorontsov@linaro.org>
References: <20120730115719.GA5742@lizard>
 <1343649500-18491-1-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <501756A0.4080405@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2012 06:58 AM, Anton Vorontsov wrote:
> Currently kernel never set KGDB_REASON_NMI. We do now, when we enter
> KGDB/KDB from an NMI.
>
> This is not to be confused with kgdb_nmicallback(), NMI callback is
> an entry for the slave CPUs during CPUs roundup, but REASON_NMI is the
> entry for the master CPU.

No need for confusion here :-)

I'll take this one for the kernel merge window if it passes regression tests, no reason not to be setting the stop codes properly.

Thanks,
Jason.
