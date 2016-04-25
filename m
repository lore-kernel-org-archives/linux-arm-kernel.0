From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 18:11:55 +0200
Subject: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
In-Reply-To: <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
Message-ID: <6110512.c3CSTNRIy3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 18:13:00 Robin Murphy wrote:
> Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
> accessor macros as conditional wrappers") makes the *_relaxed forms of
> I/O accessors universally available to drivers, in cases where writeq()
> is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
> end up falling back to writel() regardless of whether writel_relaxed()
> is available (identically for s/write/read/).
> 
> Add corresponding relaxed forms of the nonatomic helpers to delegate
> to the equivalent 32-bit accessors as appropriate.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Darren Hart <dvhart@linux.intel.com>
> CC: Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
