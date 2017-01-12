From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 12 Jan 2017 12:28:18 +0100
Subject: [PATCH] rtc: armada38x: hide maybe-uninitialized warning
In-Reply-To: <20170111145112.722743-1-arnd@arndb.de>
References: <20170111145112.722743-1-arnd@arndb.de>
Message-ID: <20170112112818.q2gxfgw7j3alo2ln@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/01/2017 at 15:50:31 +0100, Arnd Bergmann wrote :
> The function is too complicated for gcc to realize that this variable
> does eventually get initialized, causing a harmless warning:
> 
> drivers/rtc/rtc-armada38x.c: In function 'read_rtc_register_wa':
> drivers/rtc/rtc-armada38x.c:131:25: warning: 'index_max' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> This adds an explicit initializion at the start of the function.
> I generally try to avoid that, but it seems appropriate here,
> as we start out with max=0 as well.
> 
> Fixes: 61cffa2438e3 ("rtc: armada38x: Follow the new recommendation for errata implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Actually, I fixed that one directly in the commit yesterday as it has
been reported to me multiple times already.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
