From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 16:36:04 +0000
Subject: flush icache if VM_EXEC in flush_cache_page
In-Reply-To: <20100325153546.GA10306@desktop>
References: <20100325153546.GA10306@desktop>
Message-ID: <20100325163604.GF6590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 11:35:46PM +0800, anfei wrote:
> There is a little difference of flushing icache between flush_cache_page
> and flush_cache_range, why not make them the same?  I think they have
> the very similar semantic except the range.  If the vma is VM_EXEC, we
> should flush the icache no matter what cache type, and if it's not,  
> then it's not necessary.  Is it right?

Are you seeing a problem which is fixed by this patch, or is this just
theory?
