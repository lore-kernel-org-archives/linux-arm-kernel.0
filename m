From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Oct 2012 17:20:43 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1210201628420.24497@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Venkatraman,

On Thu, 18 Oct 2012, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.7-rc1.
> Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/

...

> Failing tests: needing investigation
> ------------------------------------

...

> PM tests:
> 
> * 3530es3beagle: hangs during off-mode dynamic idle test
>   - Unknown cause; not investigated

Looks like this commit is causing some of our power management tests to 
fail on v3.7-rc1:

commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c
Author: Venkatraman S <svenkatr@ti.com>
Date:   Wed Aug 8 14:26:52 2012 +0530

    mmc: omap_hsmmc: remove access to SYSCONFIG register

...

The failure can be seen in the following test log:

http://www.pwsan.com/omap/transcripts/20121020-3530es3beagle-off-mode-fail-pre-revert.txt

and with commit 6c31b215 reverted, the test succeeds:

http://www.pwsan.com/omap/transcripts/20121020-3530es3beagle-off-mode-fail-post-revert.txt


Could you please take a look and fix the problem?


- Paul
