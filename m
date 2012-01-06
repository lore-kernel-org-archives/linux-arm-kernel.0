From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Fri, 06 Jan 2012 14:03:01 +0100
Subject: [RFC PATCH 0/9] Remove useless on_each_cpu return value
In-Reply-To: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
Message-ID: <1325854981.2442.25.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-01-03 at 16:19 +0200, Gilad Ben-Yossef wrote:
> on_each_cpu() returns as its own return value the return value of 
> smp_call_function(). smp_call_function() in turn returns a hard 
> coded value of zero.
> 
> Some callers to on_each_cpu() waste cycles and bloat code space
> by checking the return value to on_each_cpu(), probably for 
> historical reasons.

hysterical raisins,, yumm! :-)

> This patch set refactors callers to not test on_each_cpu()
> (fixed) return value and then refactors on_each_cpu to
> return void to avoid confusing future users.
> 

Seems sane enough, fwiw:

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
