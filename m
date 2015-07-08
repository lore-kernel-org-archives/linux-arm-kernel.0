From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 8 Jul 2015 12:05:26 +0200
Subject: [PATCH 5/9] locking/qrwlock: remove redundant cmpxchg barriers
 on writer slow-path
In-Reply-To: <1436289865-2331-6-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-6-git-send-email-will.deacon@arm.com>
Message-ID: <20150708100526.GC3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 06:24:21PM +0100, Will Deacon wrote:
> +#ifndef cmpxchg_relaxed
> +# define cmpxchg_relaxed	cmpxchg
> +#endif

Should we collate this _relaxed stuff and make it 'official' instead of
these ad-hoc/in-situ things?

There's more archs that can usefully implement them than seem to have
implemented them atm. Of course that means someone doing a full arch/*
sweep, but hey.. :-)
