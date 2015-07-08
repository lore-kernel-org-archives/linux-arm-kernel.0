From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 8 Jul 2015 12:00:58 +0200
Subject: [PATCH 4/9] locking/qrwlock: implement queue_write_unlock using
 smp_store_release
In-Reply-To: <1436289865-2331-5-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-5-git-send-email-will.deacon@arm.com>
Message-ID: <20150708100058.GB3644@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 06:24:20PM +0100, Will Deacon wrote:
> smp_store_release supports byte accesses, so use that in writer unlock
> and remove the conditional macro override.
> 

Maybe mention that this is possible since:

536fa402221f ("compiler: Allow 1- and 2-byte smp_load_acquire() and
smp_store_release()")
