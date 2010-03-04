From: wolfgang@iksw-muees.de (Wolfgang =?iso-8859-1?q?M=FCes?=)
Date: Thu, 4 Mar 2010 07:54:57 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100303215437.GF2579@ucw.cz>
References: <20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267549527.15401.78.camel@e102109-lin.cambridge.arm.com>
	<20100303215437.GF2579@ucw.cz>
Message-ID: <201003040754.57800.wolfgang@iksw-muees.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Pavel Machek wrote:

> 3. Forget about PG_arch_1 and always do the flush?
> 
> How big is the performance impact? Note that current code does not
> even *work* so working, 10% slower code will be an improvement.

... and this is what *I* don't understand in this discussion. Obviously a 
flush() in PIO drivers is a clean and quick solution to the problem. And how 
much execution time will it cost - given the fact that if there is NO flush, 
the flush operation will not be avoided, only delayed (up to the time the data 
cache is doing the flush himself). If the data cache is doing the flush BEFORE 
the data is used in userspace (this includes the most common case of reading 
large files from the device), there will be no performance impact.

Just my 2 cents.

regards
Wolfgang
-- 
Wahre Worte sind nicht sch?n - Sch?ne Worte sind nicht wahr. (Laotse)
