From: jpoimboe@redhat.com (Josh Poimboeuf)
Date: Fri, 10 Aug 2018 15:44:49 -0500
Subject: [PATCH 3/3] arm64: reliable stacktraces
In-Reply-To: <20180810160311.C988D68CF4@newverein.lst.de>
References: <20180810160043.9E45568C76@newverein.lst.de>
 <20180810160311.C988D68CF4@newverein.lst.de>
Message-ID: <20180810204449.4asgonydn6yfb6kq@treble>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 06:03:11PM +0200, Torsten Duwe wrote:
> This is more an RFC in the original sense: is this basically
> the correct approach? (as I had to tweak the API a bit).
> 
> In particular the code does not detect interrupts and exception
> frames, and does not yet check whether the code address is valid.
> The latter check would also have to be omitted for the latest frame
> on other tasks' stacks. This would require some more tweaking.
> 
> unwind_frame() now reports whether we had to stop normally or due to
> an error condition; walk_stackframe() will pass that info.
> __save_stack_trace() is used for a start to check the validity of a
> frame; maybe save_stack_trace_tsk_reliable() will need its own callback.
> 
> Any comments welcome.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

Before we do this we'll need the same analysis we did for ppc64le to
figure out if objtool is needed.

-- 
Josh
