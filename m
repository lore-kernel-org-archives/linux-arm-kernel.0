From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Nov 2012 23:49:14 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc4
In-Reply-To: <87390iicno.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com>
 <87390iicno.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1211092347520.20703@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Nov 2012, Kevin Hilman wrote:

> I found that disabling MMC in the config made the tests pass again, so
> then bisected it down to the commit below removing SYSCONFIG
> accesses[2].  I haven't had the time to find out exactly the cause, but
> clearly the code that was removed was doing something that hwmod is not
> taking care of automatically.
> 
> Venkat, Felipe, could you please investigate this and hopefully get a
> fix out for v3.7-rc?

This one might fix it -- it fixes another PM bug in the v3.7-rcs involving 
the same commit:

http://git.kernel.org/?p=linux/kernel/git/pjw/omap-pending.git;a=commit;h=613ad0e98c3596cd2524172fae2a795c3fc57e4a


- Paul
