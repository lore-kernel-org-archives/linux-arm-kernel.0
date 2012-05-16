From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 16 May 2012 15:33:26 +0200
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20120516133850.GA3764@S2100-06.ap.freescale.net>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
 <20403.41495.610333.670008@ipc1.ka-ro>
 <20120516133850.GA3764@S2100-06.ap.freescale.net>
Message-ID: <20403.44198.671025.83880@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Wed, May 16, 2012 at 02:48:23PM +0200, Lothar Wa?mann wrote:
> > But you are changing the behaviour of existing software that
> > apparently did not suffer from this problem.
> 
> It's exactly the reason why you chose to fix the problem in gpio-mxc
> instead of gpio-generic, right?  You thought other gpio-generic users
> like gpio-mxs does not suffer from this problem.  Sadly, it's not the
> case.
> 
> The updated patch simply corrects behaviour of gpio-generic for all
> the users.
> 
> > You should make sure that
> > the fix for your problem is not causing new problems for other users!
> > 
> I'm not fixing a gpio-mxs problem but a gpio-generic one.  Can you help
>
Yes, I know. And that's exaclty why you should make sure that you
don't break other platforms by fixing yours!

> me understand what the new problems could possibly be introduced for
> other gpio-generic users by the changes? 
> 
Another platform using might be working just _because_ of the "broken"
behaviour. By fixing that brokenness for your driver you may break
that other platform.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
