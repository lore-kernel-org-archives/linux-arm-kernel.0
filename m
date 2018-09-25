From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Sep 2018 15:06:25 +0100
Subject: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
In-Reply-To: <20180925095316.GA27420@toy>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180924171936.q5bfvczzllmm5lpe@lakrids.cambridge.arm.com>
 <20180925095316.GA27420@toy>
Message-ID: <20180925140624.7wovo2xtpyihyt3j@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 05:53:16PM +0800, Jun Yao wrote:
> On Mon, Sep 24, 2018 at 06:19:36PM +0100, Mark Rutland wrote:
> > I've pushed a branch with the cleanups I requested [1] folded in.
> > 
> > I'm still a bit worried about the pgd lock, but otherwise I think this
> > is sound. I intend to throw some testing at it, just in case.
> > 
> > If you're happy with that branch, I'll ask Will and Catalin to consider
> > picking it up.
> 
> This branch looks great. Thank you for improving my patch.

Thanks for your patches!

> Is there anything I need to do? This is my first time to submit a patch,
> so I am a bit overwhelmed. I think I should wait for other people to
> review my patch. If there is a problem, I need to fix it.

Hopefully Catalin is happy to pick this up from my branch, and neither
of us have to do anything. :)

Catalin, are you happy to pick the patches from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ro-swapper

... that should be based on the arm64 for-next/core branch, and has
James's R-B prior to my commit fixup notes.

I've given this some basic testing with defconfig, 48-bit/4k and
42-bit/64k (with lockdep on in both cases), and things seem fine.

Thanks,
Mark.
