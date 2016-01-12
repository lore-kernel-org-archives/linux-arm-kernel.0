From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Mon, 11 Jan 2016 17:14:14 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <1452426622-4471-12-git-send-email-mst@redhat.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
Message-ID: <56945366.2090504@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2016 06:18 AM, Michael S. Tsirkin wrote:
> On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
> smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
> the asm-generic variants exactly. Drop the local definitions and pull in
> asm-generic/barrier.h instead.
>
This statement doesn't fit MIPS barriers variations. Moreover, there is 
a reason to extend that even more specific, at least for 
smp_store_release and smp_load_acquire, look into

     http://patchwork.linux-mips.org/patch/10506/

- Leonid.
