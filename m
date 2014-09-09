From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Sep 2014 14:19:07 -0300
Subject: [PATCHv2 2/3] [media] s5p-jpeg: Fix compilation with COMPILE_TEST
In-Reply-To: <20140909131036.7265121f.m.chehab@samsung.com>
References: <20140909124306.2d5a0d76@canb.auug.org.au>
 <6cbd00c5f2d342b573aaf9c0e533778374dd2e1e.1410273306.git.m.chehab@samsung.com>
 <b7343e6296b5d1d68b7229b8307442fd4141bcb3.1410273306.git.m.chehab@samsung.com>
 <540F15B2.3000902@samsung.com>
 <20140909120936.527bd852.m.chehab@samsung.com>
 <540F1D11.9030400@samsung.com>
 <20140909131036.7265121f.m.chehab@samsung.com>
Message-ID: <CAOMZO5ASN_Kcp4q-stmsoXBFcmtJLyyeEEpwy=U40qqghT7vXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 1:10 PM, Mauro Carvalho Chehab
<m.chehab@samsung.com> wrote:
> ERROR: "__bad_ndelay" [drivers/media/platform/s5p-jpeg/s5p-jpeg.ko] undefined!
>
> That happens because asm-generic doesn't like any ndelay time
> bigger than 20us.
>
> Currently, usleep_range() couldn't simply be used, since
> exynos4_jpeg_sw_reset() is called with a spinlock held.
>
> So, let's use ndelay() instead.

You meant 'udelay() instead'.
