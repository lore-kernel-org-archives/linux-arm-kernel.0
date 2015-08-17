From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Aug 2015 13:07:05 +0100
Subject: [PATCH] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu9j2_u4Bbtr+yvSfiNe_Vw4ZapO+r1xqxSUmbVBJ4GB3w@mail.gmail.com>
References: <1439640824-30498-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150817104049.GB2482@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_9zx5gZBRWO_Yg082Afoc7ksy2yJm-1xqprq06ptLJQw@mail.gmail.com>
 <20150817110454.GC2482@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9j2_u4Bbtr+yvSfiNe_Vw4ZapO+r1xqxSUmbVBJ4GB3w@mail.gmail.com>
Message-ID: <20150817120705.GD2482@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 01:06:35PM +0200, Ard Biesheuvel wrote:
> On 17 August 2015 at 13:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Aug 17, 2015 at 12:44:50PM +0200, Ard Biesheuvel wrote:
> >> I proposed to override early_init_dt_add_memory_arch() completely
> >> instead, but Rob had some comments, after which the discussion kind of
> >> fizzled out.
> >
> > I don't think we should override early_init_dt_add_memory_arch(), unless
> > we diverge too much from it. Currently, it looks to me like the end of
> > PA range check is pretty useless in this function.
> 
> OK. But note that, when we decouple the linear mapping from the
> mapping of the kernel image, we will need to override this function
> anyway.

That's fine. I assume we'll keep the DT memblock checking in the same
place. The main issue I have with your patch is the split of lower
blocks rejected by one function and higher blocks by another.

-- 
Catalin
