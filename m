From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Aug 2012 14:07:08 +0000
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <201208031407.09092.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 August 2012, Uwe Kleine-K?nig wrote:
> Hello,
> 
> the only changes compared to v5 (sent starting with Message-id:
> 1341512035-8173-1-git-send-email-u.kleine-koenig at pengutronix.de)
> are that several debug pr_infos were dropped that I missed to remove
> before. Thanks to Will Deacon for pointing out that problem.
> Furthermore I rebased (trivially) to v3.5.

No objections to the code from my side, but I'd like to understand
the big picture here. You introduce a new CPU_V7M configuration
symbol in the code, but there is no Kconfig change that introduces
that symbol. Is that another change that is still coming?

None of the code seems to be specific to Cortex-M3 rather than the
ARMv7M architecture. Does that mean it is expected to run
unmodifed on both M3 and M4, and possibly future ARMv-7M cores?

Is it possible to build a NOMMU kernel that runs on both ARMv7-A
amd ARMv7-M, in other words is ARMv7-M compatible with ARMv7-A
(or ARMv7-R for that matter) if you don't use the MMU?

How does this relate to the ARMv6-M (Cortex-M0/M0+/M1) support
that has been floating around [1]? Can we support both in
the same kernel? 

	Arnd

[1] http://developer.petalogix.com/git/gitweb.cgi?p=linux-2.6.x-cortexm1.git;a=summary
