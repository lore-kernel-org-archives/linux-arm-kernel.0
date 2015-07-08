From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 8 Jul 2015 09:02:25 +0200
Subject: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
In-Reply-To: <20150708064607.GB7079@osiris>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
 <20150708064607.GB7079@osiris>
Message-ID: <CAMuHMdUS72nYDo=chtcZMv-ZNVU0RhxvVLvMYvSFLtRk_wXrgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 8, 2015 at 8:46 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
>> index 1acad02..f6d81d6 100644
>> --- a/arch/s390/kernel/syscalls.S
>> +++ b/arch/s390/kernel/syscalls.S
>> @@ -363,3 +363,6 @@ SYSCALL(sys_bpf,compat_sys_bpf)
>>  SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
>>  SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
>>  SYSCALL(sys_execveat,compat_sys_execveat)
>> +SYSCALL(sys_mlock2,compat_sys_mlock2)                        /* 355 */
>> +SYSCALL(sys_munlock2,compat_sys_munlock2)
>> +SYSCALL(sys_munlockall2,compat_sys_munlockall2)
>
> FWIW, you would also need to add matching lines to the two files
>
> arch/s390/include/uapi/asm/unistd.h
> arch/s390/kernel/compat_wrapper.c
>
> so that the system call would be wired up on s390.

Similar comment for m68k:

arch/m68k/include/asm/unistd.h
arch/m68k/include/uapi/asm/unistd.h

I think you best look at the last commits that added system calls, for all
architectures, to make sure you don't do partial updates.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
