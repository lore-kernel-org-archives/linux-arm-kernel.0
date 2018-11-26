From: rick.p.edgecombe@intel.com (Edgecombe, Rick P)
Date: Mon, 26 Nov 2018 17:02:35 +0000
Subject: [PATCH v4 1/2] bpf: add __weak hook for allocating executable
 memory
In-Reply-To: <20181123221804.440-2-ard.biesheuvel@linaro.org>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
 <20181123221804.440-2-ard.biesheuvel@linaro.org>
Message-ID: <a16dc0bb806d6a0685978bb94c2e3f19588c063f.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-11-23 at 23:18 +0100, Ard Biesheuvel wrote:
> By default, BPF uses module_alloc() to allocate executable memory,
> but this is not necessary on all arches and potentially undesirable
> on some of them.
> 
> So break out the module_alloc() and module_memfree() calls into __weak
> functions to allow them to be overridden in arch code.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

It looks like some of the architectures call module_alloc directly in their
bpf_jit_compile implementations as well.

Rick
