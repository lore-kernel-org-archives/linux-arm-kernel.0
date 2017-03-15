From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Mar 2017 11:41:18 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <1489578078.4195.113.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-15 at 18:56 +0900, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
> 
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v6 [2].
> For your convinience, you can pick them up from:
> ?? https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git?arm64/kdump
> ?? https://git.linaro.org/people/takahiro.akashi/kexec-tools.git?arm64/kdump
> 
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> ? - crash utility (v7.1.8 or later) [3]
> 
> I tested this patchset on fast model and hikey.

Please build with CONFIG_DEBUG_SECTION_MISMATCH=y.

It might be because I'm using your v32 patchset, hacked late at night
to apply to a 4.9 kernel, but I see this:

WARNING: vmlinux.o(.text+0x10240): Section mismatch in reference from the function arch_kexec_protect_crashkres() to the function .init.text:create_pgd_mapping()
The function arch_kexec_protect_crashkres() references
the function __init create_pgd_mapping().
This is often because arch_kexec_protect_crashkres lacks a __init?
annotation or the annotation of create_pgd_mapping is wrong.

WARNING: vmlinux.o(.text+0x102b0): Section mismatch in reference from the function arch_kexec_unprotect_crashkres() to the function .init.text:create_pgd_mapping()
The function arch_kexec_unprotect_crashkres() references
the function __init create_pgd_mapping().
This is often because arch_kexec_unprotect_crashkres lacks a __init?
annotation or the annotation of create_pgd_mapping is wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/943556e5/attachment-0001.bin>
