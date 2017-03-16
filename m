From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 16 Mar 2017 09:23:48 +0900
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <1489578078.4195.113.camel@infradead.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489578078.4195.113.camel@infradead.org>
Message-ID: <20170316002347.GA11935@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 11:41:18AM +0000, David Woodhouse wrote:
> On Wed, 2017-03-15 at 18:56 +0900, AKASHI Takahiro wrote:
> > This patch series adds kdump support on arm64.
> > 
> > To load a crash-dump kernel to the systems, a series of patches to
> > kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> > For your convinience, you can pick them up from:
> > ?? https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git?arm64/kdump
> > ?? https://git.linaro.org/people/takahiro.akashi/kexec-tools.git?arm64/kdump
> > 
> > To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> > ? - crash utility (v7.1.8 or later) [3]
> > 
> > I tested this patchset on fast model and hikey.
> 
> Please build with CONFIG_DEBUG_SECTION_MISMATCH=y.
> 
> It might be because I'm using your v32 patchset, hacked late at night
> to apply to a 4.9 kernel, but I see this:
> 
> WARNING: vmlinux.o(.text+0x10240): Section mismatch in reference from the function arch_kexec_protect_crashkres() to the function .init.text:create_pgd_mapping()
> The function arch_kexec_protect_crashkres() references
> the function __init create_pgd_mapping().
> This is often because arch_kexec_protect_crashkres lacks a __init?
> annotation or the annotation of create_pgd_mapping is wrong.
> 
> WARNING: vmlinux.o(.text+0x102b0): Section mismatch in reference from the function arch_kexec_unprotect_crashkres() to the function .init.text:create_pgd_mapping()
> The function arch_kexec_unprotect_crashkres() references
> the function __init create_pgd_mapping().
> This is often because arch_kexec_unprotect_crashkres lacks a __init?
> annotation or the annotation of create_pgd_mapping is wrong.

I double-checked but saw no warnings like these neither for v32 nor v33.
I'm afraid that you might have done something wrong in backporting,
particularly patch#5.

Thanks,
-Takahiro AKASHI
