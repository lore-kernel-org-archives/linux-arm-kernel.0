From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 20 Apr 2010 15:51:22 -0700
Subject: Suspicious compilation warning
In-Reply-To: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
References: <k2ncecb6d8f1004191627w3cd36450xf797f746460abb09@mail.gmail.com>
Message-ID: <20100420155122.6f2c26eb.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Apr 2010 20:27:43 -0300
Marcelo Jimenez <mroberto@cpti.cetuc.puc-rio.br> wrote:

> I get this warning while compiling for ARM/SA1100:
> 
> mm/sparse.c: In function '__section_nr':
> mm/sparse.c:135: warning: 'root' is used uninitialized in this function
> 
> With a small patch in fs/proc/meminfo.c, I find that NR_SECTION_ROOTS
> is zero, which certainly explains the warning.
> 
> # cat /proc/meminfo
> NR_SECTION_ROOTS=0
> NR_MEM_SECTIONS=32
> SECTIONS_PER_ROOT=512
> SECTIONS_SHIFT=5
> MAX_PHYSMEM_BITS=32

hm, who owns sparsemem nowadays? Nobody identifiable.

Does it make physical sense to have SECTIONS_PER_ROOT > NR_MEM_SECTIONS?
