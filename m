From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 6 May 2011 10:45:40 +0100
Subject: [PATCH] ARM: S3C6410: Add some lower frequencies for 800MHz
	base clock operation
In-Reply-To: <00fa01cc0baa$3af45a20$b0dd0e60$%kim@samsung.com>
References: <1304004383-16133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<00fa01cc0baa$3af45a20$b0dd0e60$%kim@samsung.com>
Message-ID: <20110506094540.GD23729@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2011 at 01:58:21PM +0900, Kukjin Kim wrote:

> Hmm, I'm not sure this should be OK...because guided(or tested?) dvfs level
> is following for 800Mhz.
> L3: 133, L2: 266, L1: 400 and L0: 800.

> And I couldn't find about supporting of 100Mhz or 200Mhz in its hw design
> guide. Of course, it doesn't mean this is wrong but at least need to check
> again.

It appears to work for me in my tests; I've been running my systems like
this since I introduced the change.  Since it's the same divisions down
from 800MHz as the existing ones from 667MHz and the part supports
operation down to 66MHz so all the frequencies are well within the
absolute limits I'd be a little surprised if there were any problems.
As I've not yet been able to obtain the design guide I've no idea about
any information it may provide.
