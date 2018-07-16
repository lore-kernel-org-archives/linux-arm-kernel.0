From: dyoung@redhat.com (Dave Young)
Date: Mon, 16 Jul 2018 20:26:23 +0800
Subject: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <20180711074203.3019-4-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
Message-ID: <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> Memblock list is another source for usable system memory layout.
> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> other memblock-based architectures, particularly arm64, can also utilise
> it. A moved function is now renamed to kexec_walk_memblock() and merged
> into the existing arch_kexec_walk_mem() for general use, either resource
> list or memblock list.
> 
> A consequent function will not work for kdump with memblock list, but
> this will be fixed in the next patch.

If this breaks something, then it would be good to fold the following
patch in this patch so that bisect can still work?

Thanks
Dave
