From: slash.tmp@free.fr (Mason)
Date: Thu, 04 Jun 2015 22:32:40 +0200
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <20150604200850.GF5710@saruman.tx.rr.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel> <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com> <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com> <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
Message-ID: <5570B5E8.90300@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2015 22:08, Felipe Balbi wrote:

> On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
>> Also, check /proc/timer_list for a "Broadcast device". If you don't
>> define one, the TWD timers are set to periodic mode, with hrtimers
>> disabled.
> 
> Did you manage to turn global timer into Broadcast device ?

Disclaimer: I am a kernel noob, take everything I say with
a rock of salt.

As far as I can see, the global timer code doesn't handle
frequency changes, whereas the TWD code does.

Yet all these timers are clocked by PERIPHCLK, which is defined
as CPUCLK / N. So if a platform enables cpufreq, CPUCLK will
vary, meaning PERIPHCLK will vary. I don't see how the global
timer can work in that situation.

cf. also this recent thread:
http://thread.gmane.org/gmane.linux.kernel.cpufreq/15770

Regards.
