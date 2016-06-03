From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 3 Jun 2016 23:38:29 +0200
Subject: [PATCH 1/2] perf: allow add to change event state
In-Reply-To: <1464987812-14360-2-git-send-email-nleeder@codeaurora.org>
References: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
 <1464987812-14360-2-git-send-email-nleeder@codeaurora.org>
Message-ID: <20160603213829.GD3710@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 05:03:31PM -0400, Neil Leeder wrote:
> When the platform-specific pmu->add function returns
> an error, it may have also changed the event's state.
> If so, do not override that new state.

This is inadequate; it fails to what the problem is and why this is a
good solution.
