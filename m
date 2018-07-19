From: dyoung@redhat.com (Dave Young)
Date: Thu, 19 Jul 2018 10:23:25 +0800
Subject: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
In-Reply-To: <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
 <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
Message-ID: <20180719022325.GA2773@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,
On 07/18/18 at 05:52pm, James Morse wrote:
> Hi Dave, Akashi,
> 
> On 16/07/18 13:26, Dave Young wrote:
> > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> >> Memblock list is another source for usable system memory layout.
> >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> >> other memblock-based architectures, particularly arm64, can also utilise
> >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> >> into the existing arch_kexec_walk_mem() for general use, either resource
> >> list or memblock list.
> >>
> >> A consequent function will not work for kdump with memblock list, but
> >> this will be fixed in the next patch.
> > 
> > If this breaks something, then it would be good to fold the following
> > patch in this patch so that bisect can still work?
> 
> This patch is just moving code from arch/powerpc that is generic.
> powerpc doesn't support kdump via kexec_file, so nothing is damaged by adding
> this new code in the next patch.
> 
> arm64 would need this kdump support, but it doesn't use it until patch 11.

Ok, then I'm fine with it, thanks for the explanation.

> 
> 
> Thanks,
> 
> James

Thanks
Dave
