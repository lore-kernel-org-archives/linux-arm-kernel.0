From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 05 Aug 2016 17:46:43 -0300
Subject: [PATCH v2 3/3] kexec: extend kexec_file_load system call
In-Reply-To: <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-ID: <1988385.QMVjiCbb5e@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 26 Juli 2016, 21:24:29 schrieb Thiago Jung Bauermann:
> Notes:
>     This is a new version of the last patch in this series which adds
>     a function where each architecture can verify if the DTB is safe
>     to load:
> 
>     int __weak arch_kexec_verify_buffer(enum kexec_file_type type,
>                                         const void *buf,
>                                         unsigned long size)
>     {
>             return -EINVAL;
>     }
> 
>     I will then provide an implementation in my powerpc patch series
>     which checks that the DTB only contains nodes and properties from a
>     whitelist. arch_kexec_kernel_image_load will copy these properties
>     to the device tree blob the kernel was booted with (and perform
>     other changes such as setting /chosen/bootargs, of course).

Is this approach ok? If so, I'll post a patch next week adding an 
arch_kexec_verify_buffer hook for powerpc to enforce the whitelist, and also 
a new version of the patches implementing kexec_file_load for powerpc on top 
of this series.

Eric, does this address your concerns?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
