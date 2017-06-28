From: bp@suse.de (Borislav Petkov)
Date: Wed, 28 Jun 2017 18:55:14 +0200
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <5953DC82.2000602@arm.com>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
 <5953DC82.2000602@arm.com>
Message-ID: <20170628165514.kltemqgaxxhgw5as@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 05:42:42PM +0100, James Morse wrote:
> > Alternatively, you can extend arm_event to get issued with *each*
> > cper_arm_err_info but that would mean a lot of redundant information
> > being shuffled out to userspace.
> 
> I think this is what we should do,

Yes, that should be easier for userspace.

> but only keep the number of fields we export to a minimum. If we
> always use the names in the spec, and user-space always parses the
> 'format' file, we should be able to add more fields when they turn out
> to be necessary. (looks like the trace infrastructure makes inventing
> a new format easy!)

Right, except if you have userspace consumers already using them, you're
potentially breaking them. Unless you teach them all to parse the format
file first, from the very beginning. But in general, we try to be very
wary when touching tracepoints as they become an ABI of sorts.

Also, do try to shovel only the really needed info to userspace - not
everything the spec dumps but maybe just the fields that are really
necessary for doing hw error recovery.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
