From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 21:38:51 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.41495.610333.670008@ipc1.ka-ro>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
 <20403.41495.610333.670008@ipc1.ka-ro>
Message-ID: <20120516133850.GA3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 02:48:23PM +0200, Lothar Wa?mann wrote:
> But you are changing the behaviour of existing software that
> apparently did not suffer from this problem.

It's exactly the reason why you chose to fix the problem in gpio-mxc
instead of gpio-generic, right?  You thought other gpio-generic users
like gpio-mxs does not suffer from this problem.  Sadly, it's not the
case.

The updated patch simply corrects behaviour of gpio-generic for all
the users.

> You should make sure that
> the fix for your problem is not causing new problems for other users!
> 
I'm not fixing a gpio-mxs problem but a gpio-generic one.  Can you help
me understand what the new problems could possibly be introduced for
other gpio-generic users by the changes? 

-- 
Regards,
Shawn
