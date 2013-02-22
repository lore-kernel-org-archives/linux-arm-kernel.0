From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 22 Feb 2013 14:48:46 +0100
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <20130222125019.GC17948@somewhere.redhat.com>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361522767.26780.44.camel@laptop>
 <20130222125019.GC17948@somewhere.redhat.com>
Message-ID: <1361540926.26780.56.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 13:50 +0100, Frederic Weisbecker wrote:
> atomic64_read() and atomic64_set() are supposed to take care of that,
> without
> even the need for _inc() or _add() parts that use LOCK.

Are you sure? Generally atomic*_set() is not actually an atomic
operation.
