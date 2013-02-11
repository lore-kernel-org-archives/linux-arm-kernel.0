From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 10 Feb 2013 23:35:44 -0500 (EST)
Subject: v3.8-rc issues with big endian
In-Reply-To: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360451709-19740-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1302102335150.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 Feb 2013, Ben Dooks wrote:

> Whilst debugging with big endian ARM on v3.8-rc I came across a problem
> with the new ASID code (commit b5466f8728527a05a493cc4abe9e6f034a1bbaab)
> which is causing issues with user-land failing to work.
> 
> Since the new ASID code is using 64-bit accesses, the ASID ID is now
> being placed in context->id + 4, which means that the assembly mm code
> no-longer works.
> 
> I also noticed and fixed a couple of places where the new mmid macro was
> not being used, so fixed those too.
> 
> Tested on a highbank system.
> 
>  [PATCH 1/2] ARM: mm: replace direct access to mm->context.id with
>  [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian

For both patches:

Acked-by: Nicolas Pitre <nico@linaro.org>



> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
