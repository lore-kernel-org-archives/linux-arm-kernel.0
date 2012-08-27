From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2012 11:54:48 +0100
Subject: For buddy system initialization, the holes between banks
 adjacent will be released to buddy allocator?
In-Reply-To: <CAFNq8R6TgfdAbDDTQTyt6hncA+OHAy7SkNpzdGuABcAtaegTiw@mail.gmail.com>
References: <CAFNq8R6kBonhW4Q+Zj_6GV7y88pcAUJ_MrYn1nYM9LHtMZqdvQ@mail.gmail.com>
 <CAFNq8R7fCyD5P4mAA8LGzcOvVynSJa8mOBDwrLOF9mVvo9q5VA@mail.gmail.com>
 <20120827080913.GL18957@n2100.arm.linux.org.uk>
 <CAFNq8R6TgfdAbDDTQTyt6hncA+OHAy7SkNpzdGuABcAtaegTiw@mail.gmail.com>
Message-ID: <20120827105448.GO18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2012 at 06:30:42PM +0800, Li Haifeng wrote:
> 2012/8/27 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Mon, Aug 27, 2012 at 10:42:40AM +0800, Li Haifeng wrote:
> >> Just now, I tested it on my ARM development board.
> >>
> >> The holes between banks does be released to buddy allocator. And the
> >> buddy system will allocate holes for thread, which will cause fault.
> >> Is it right?
> >
> > Could you rephrase your question please?
> 
> The code below is to release free memory to buddy allocator, according
> to node_bootmem_map.
> 
> The lines 180~181 get the low memory's range, and the range includes holes.
> But while releasing the memory to buddy allocator, the code doesn't
> prevent the holes from releasing to the buddy allocator. So, if the
> holes are allocated to thread, fault will happen.

The whole purpose _is_ to allow these pages to be re-used, rather than
being tied up uselessly in the map where they're not being used.
