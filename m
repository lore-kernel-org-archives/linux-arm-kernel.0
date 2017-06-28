From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 28 Jun 2017 13:38:55 -0400
Subject: [PATCH v5] trace: ras: add ARM processor error information
 trace event
In-Reply-To: <20170628165514.kltemqgaxxhgw5as@pd.tnic>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
 <5953DC82.2000602@arm.com>
 <20170628165514.kltemqgaxxhgw5as@pd.tnic>
Message-ID: <20170628133855.65509c93@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Jun 2017 18:55:14 +0200
Borislav Petkov <bp@suse.de> wrote:


> > but only keep the number of fields we export to a minimum. If we
> > always use the names in the spec, and user-space always parses the
> > 'format' file, we should be able to add more fields when they turn out
> > to be necessary. (looks like the trace infrastructure makes inventing
> > a new format easy!)  
> 
> Right, except if you have userspace consumers already using them, you're
> potentially breaking them. Unless you teach them all to parse the format
> file first, from the very beginning. But in general, we try to be very
> wary when touching tracepoints as they become an ABI of sorts.

No no. You can add new fields easily. There should be no breakage, as
the userspace tools should be using the traceevent library code. It
only breaks when you remove a field. Which reminds me, I really need to
get that out into distros *this* year. I've been putting this off for
far too long.

The ras tool has its own copy of the traceevent library parser.

-- Steve


> 
> Also, do try to shovel only the really needed info to userspace - not
> everything the spec dumps but maybe just the fields that are really
> necessary for doing hw error recovery.
> 
