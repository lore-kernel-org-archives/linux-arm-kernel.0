From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 13 Jul 2015 12:28:48 +0200
Subject: [PATCH 13/18] arm64: cmpxchg: avoid memory barrier on comparison
 failure
In-Reply-To: <1436779519-2232-14-git-send-email-will.deacon@arm.com>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-14-git-send-email-will.deacon@arm.com>
Message-ID: <20150713102848.GX19282@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:25:14AM +0100, Will Deacon wrote:
> cmpxchg doesn't require memory barrier semantics when the value
> comparison fails, so make the barrier conditional on success.

So this isn't actually a documented condition.

I would very much like a fwe extra words on this, that you've indeed
audited cmpxchg() users and preferably even a Documentation/ update to
match.
