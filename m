From: dyoung@redhat.com (Dave Young)
Date: Fri, 25 Aug 2017 13:47:49 +0800
Subject: [PATCH 05/14] kexec_file: factor out crashdump elf header
 function from x86
In-Reply-To: <20170824081811.19299-6-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-6-takahiro.akashi@linaro.org>
Message-ID: <20170825054749.GA8604@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/17 at 05:18pm, AKASHI Takahiro wrote:
> prepare_elf_headers() can also be useful for other architectures,
> including arm64. So let it factored out.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/kernel/crash.c | 324 ----------------------------------------------
>  include/linux/kexec.h   |  19 +++
>  kernel/crash_core.c     | 333 ++++++++++++++++++++++++++++++++++++++++++++++++

It looks better to add these to kexec_file.c instead.

Thanks
Dave
