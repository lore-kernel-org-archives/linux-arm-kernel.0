From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 10 May 2018 20:44:12 +0530
Subject: [PATCH] kvm: Change return type to vm_fault_t
In-Reply-To: <20180419155606.45a85009.cohuck@redhat.com>
References: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
 <20180419155606.45a85009.cohuck@redhat.com>
Message-ID: <CAFqt6zYUpKOibZn-e42LnzkXc6a4bu35PZcOAsDwDZV5RzaUXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 7:26 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Thu, 19 Apr 2018 00:49:58 +0530
> Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>  arch/mips/kvm/mips.c       | 2 +-
>>  arch/powerpc/kvm/powerpc.c | 2 +-
>>  arch/s390/kvm/kvm-s390.c   | 2 +-
>>  arch/x86/kvm/x86.c         | 2 +-
>>  include/linux/kvm_host.h   | 2 +-
>>  virt/kvm/arm/arm.c         | 2 +-
>>  virt/kvm/kvm_main.c        | 2 +-
>>  7 files changed, 7 insertions(+), 7 deletions(-)
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

If no further comment, We would like to get this
patch in queue for 4.18.
