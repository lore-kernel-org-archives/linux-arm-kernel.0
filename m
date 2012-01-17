From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 19:09:25 +0000
Subject: [PATCH v3 2/3] ARM: vmlinux.lds.S: align the exception fixup
 table to a 4-byte boundary
In-Reply-To: <alpine.LFD.2.02.1201171314120.2722@xanadu.home>
References: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
 <1326818876-4818-2-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1201171314120.2722@xanadu.home>
Message-ID: <20120117190925.GK27350@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 06:18:47PM +0000, Nicolas Pitre wrote:
> On Tue, 17 Jan 2012, Will Deacon wrote:
> 
> > The exception fixup table is currently aligned to a 32-byte boundary.
> > Whilst this won't cause any problems, the exception_table_entry
> > structures contain only a pair of unsigned longs, so 4-byte alignment
> > is all that is required.
> 
> If the table was also walked from start to end, that could also be an 
> argument for aligning it to a cache line so the first access always 
> fetches a whole cache line worth of usable data.  But the access is done 
> through a binary search which is totally random as far as access pattern 
> goes.  That would be worth mentioning in the commit log.

Good point, I'll add that to the message.

> With that:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Thanks Nicolas!

Will
