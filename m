From: dave@stgolabs.net (Davidlohr Bueso)
Date: Sun, 02 Aug 2015 13:50:31 -0700
Subject: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Message-ID: <1438548631.2249.125.camel@stgolabs.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-08-02 at 17:11 +0200, Andrey Konovalov wrote:
> Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
> with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
> powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
> reliably on non-scalar types.
> 
> WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
> ("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
> Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>
