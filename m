From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 08 Oct 2010 11:17:44 -0700
Subject: [PATCH] davinci: Implement sched_clock()
In-Reply-To: <4CAEE9DA.1020900@mvista.com> (Sergei Shtylyov's message of "Fri,
	08 Oct 2010 13:52:26 +0400")
References: <1286354335-31819-1-git-send-email-Andreas.Gaer@baslerweb.com>
	<87pqvm9bbv.fsf@deeprootsystems.com> <4CAEE9DA.1020900@mvista.com>
Message-ID: <87mxqoy2ev.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> Hello.
>
> On 07-10-2010 21:12, Kevin Hilman wrote:
>
>>> Overwrite the default implementation of sched_clock that is based on
>>> jiffies by something more precise. This improves timestamps in ftrace.
>>> Implementation is copied from OMAP platform code.
>
>>> Signed-off-by: Andreas Gaeer<Andreas.Gaer@baslerweb.com>
>
>> Thanks, applying to davinci git.
>
>> Will queue for 2.6.38 (it's a bit too late for 2.6.37 as Linus only
>> wants real regression fixes after -rc6.)
>
>    Did you mean 2.6.37 and 2.6.36 respecitvely?

Nope.

IOW, for the upcoming merge window (2.6.37), Linus does not want to see
new features done after 2.6.36-rc6.  He wants to sure that by the time
the merge window opens, that things have received some testing and
validation, particularily in linux-next.

This means, that most maintainers (myself included) will not be taking
patches/features for 2.6.N merge window after 2.6.(N-1)-rc6 is released,
unless they are regression fixes.

Kevin
