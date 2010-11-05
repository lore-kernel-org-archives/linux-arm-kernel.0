From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 5 Nov 2010 21:59:41 +0800
Subject: CONFIG_FORCE_MAX_ZONEORDER settable for all ARM architectures
In-Reply-To: <4CD40976.1080009@gmail.com>
References: <4CD40976.1080009@gmail.com>
Message-ID: <AANLkTikjQhKXgYzczAx70R3JkQ=DoE-xFNux=s6jUeLB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 5, 2010 at 9:41 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi,
>
> on a PXA3xx based platform, we want to allocate 8MByte of physically
> contiguous memory for the framebuffer device.
>
> However, alloc_pages() fails because MAX_ORDER is hard-coded to 11 for
> this architecture.
>
> Is there any reason why CONFIG_FORCE_MAX_ZONEORDER is constrained to
> ARCH_SHMOBILE in arch/arm/Kconfig? Would a patch to remove this
> limitation be accepted? Or is there any better way to allocate that
> amount and type of memory?
>

There is actually an on-going discussion of memory region allocator,
basically can
be used to solve the allocation of large chunk of physically
contiguous memory by
memory migration at run-time. Some of the ideas were mentioned in a previous
patch of CMA (contiguous memory allocator)? Though I didn't look too much into
that thread.

However, I'm not really sure about how the size of the memory region is chosen
and if the MAX_ORDER issue can be solved as well. So I guess before that
happens in mainline, would be acceptable to adjust MAX_ZONEORDER in a
hackish way.

> Thanks,
> Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
