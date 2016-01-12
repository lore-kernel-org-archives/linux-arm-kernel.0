From: mst@redhat.com (Michael S. Tsirkin)
Date: Tue, 12 Jan 2016 10:43:36 +0200
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <56945366.2090504@imgtec.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
Message-ID: <20160112103913-mutt-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:
> On 01/10/2016 06:18 AM, Michael S. Tsirkin wrote:
> >On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> >smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> >the asm-generic variants exactly. Drop the local definitions and pull in
> >asm-generic/barrier.h instead.
> >
> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/
> 
> - Leonid.

Fine, but it matches what current code is doing.  Since that
MIPS_LIGHTWEIGHT_SYNC patch didn't go into linux-next yet, do
you see a problem reworking it on top of this patchset?

-- 
MST
