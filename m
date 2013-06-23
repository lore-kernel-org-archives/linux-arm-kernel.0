From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 23 Jun 2013 10:09:52 +0200
Subject: [PATCH] ARM: fix missing flush_kernel_dcache_page() for noMMU
In-Reply-To: <871u7w6eht.fsf@linaro.org>
References: <1371672910-9340-1-git-send-email-gmbnomis@gmail.com>
 <871u7w6eht.fsf@linaro.org>
Message-ID: <20130623080951.GA29398@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 07:30:54AM -0700, Kevin Hilman wrote:
> Simon Baatz <gmbnomis@gmail.com> writes:
> 
> > Commit 1bc3974 moved the implementation of flush_kernel_dcache_page()
> > into in mm/flush.c but did not implement it on noMMU ARM.
> >
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > Cc: <stable@vger.kernel.org> # 3.2+: 1bc3974: ARM: 7755/1
> > Cc: <stable@vger.kernel.org> # 3.2+
> > ---
> >
> > ARM 7755/1 "handle user space mapped pages in flush_kernel_dcache_page"
> > unfortunately broke the no MMU case.  Compile tested with allnoconfig and
> > at91x40_defconfig on v3.10-rc6/v3.9.6 + ARM 7755/1.  On older stable kernels
> > (3.2.47 & 3.4.49) compiled with at91x40_defconfig.
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks! Reworded according to Sergei's comment, added your Acked-by and
submitted to Russell's patch tracking system (7772/1).

- Simon
