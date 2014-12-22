From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 22 Dec 2014 11:03:08 +0100
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCB6CA0@penmbx01>
References: <20141218203904.GA25215@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
 <20141219152625.GA30666@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6CA0@penmbx01>
Message-ID: <20141222100308.GB30666@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Mon, Dec 22, 2014 at 08:32:15AM +0000, Yang, Wenyou wrote:
> > On Fri, Dec 19, 2014 at 02:50:04AM +0000, Yang, Wenyou wrote:
> > 
> > > > Furthermore, it looks like MCKRDY_TIMEOUT set to 1000 is not enough,
> > > > my board crashes in about 1 wake up to 10 with this value and works
> > > > perfectly fine with 4000.
> > >
> > > I also encountered this issue.
> > 
> > Fixed in proposed patch, since we don't timeout anymore.
> 
> I am verifying this patch. I still insist on remain the timeout.

Master Clock Ready is a special case, you need a timeout value which is 
fine at slow clock and master clock, that is, a timeout value which is 
fine despite the 10^4 difference in order of magnitude. I just don't 
know what to do, a fine timeout value for master clock is an almost 
infinite timeout on slow clock.

By the way, my board suspended and resumed every 2 seconds this 
week-end, which is about 110k suspend+wake up cycles and didn't reset on 
watchdog, which is quite a good news :-)

Regards,
Sylvain
