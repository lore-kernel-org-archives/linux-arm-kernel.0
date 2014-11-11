From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 11 Nov 2014 01:40:29 +0100
Subject: [PATCH v7 0/5] This is the 1st version of suspend for RK3288.
In-Reply-To: <7hwq76pqyz.fsf@deeprootsystems.com>
References: <1415368177-6637-1-git-send-email-zyw@rock-chips.com>
 <7hwq76pqyz.fsf@deeprootsystems.com>
Message-ID: <22835729.YDXmW0qp6M@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Freitag, 7. November 2014, 14:48:20 schrieb Kevin Hilman:
> Chris Zhong <zyw@rock-chips.com> writes:
> > RK3288 can shut down the cpu, gpu and other device controllers in suspend,
> > and it will pull the GLOBAL_PWROFF pin to high in the final stage of the
> > process of suspend, pull the pin to low again when resume.
> 
> The cover letter still doesn't state what this series applies to, or
> what its dependencies are for testing, even though it was requested in
> earlier reviews[1].  I discovered (again) by trial and error it applies
> to current linux-next.  I also discovered (as was earlier discussed[2])
> that it still does not resume using current upstream code, and those
> dependencies are not described here either.  These are the kinds of
> things that are crucial in a cover letter in order to help reviewers and
> testers not have to spend time digging through the archives trying to
> remember from the previous round of reviews.
> 
> Please, please list the out-of-tree dependencies, and how to test,
> including how you tested it, and on what hardware.

I'll second what Kevin said.

I guess the regulator suspend handling [0] is one of the requirements, but I'd 
think there is more. And while Doug had a quite long list of suspend-related 
patches in his try, for now we'll need the minimal set to enable this series 
to sucessfully wake the system again after going to suspend.


Heiko


[0] 
https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/suspend
