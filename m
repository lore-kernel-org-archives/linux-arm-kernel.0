From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Tue, 13 Mar 2018 22:00:39 -0300
Subject: [PATCH v2 2/7] kexec_file, x86,
 powerpc: factor out kexec_file_ops functions
In-Reply-To: <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
 <20180306102303.9063-3-takahiro.akashi@linaro.org>
 <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
Message-ID: <87zi3b8o94.fsf@morokweng.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Young <dyoung@redhat.com> writes:

> On 03/06/18 at 07:22pm, AKASHI Takahiro wrote:
>> As arch_kexec_kernel_image_{probe,load}(),
>> arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
>> are almost duplicated among architectures, they can be commonalized with
>> an architecture-defined kexec_file_ops array. So let's factor them out.
>> 
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kexec.h            |  2 +-
>>  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
>>  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++-----------------
>>  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
>>  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
>>  arch/x86/kernel/machine_kexec_64.c          | 45 +---------------------
>>  include/linux/kexec.h                       | 13 +++----
>>  kernel/kexec_file.c                         | 60 +++++++++++++++++++++++++++--
>>  8 files changed, 71 insertions(+), 94 deletions(-)
>> 
>
> For this patch it also needs some review from powerpc people. 

FWIW:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Also, tested on a ppc64le KVM guest:

Tested-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
