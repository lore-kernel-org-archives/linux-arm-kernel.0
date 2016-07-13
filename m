From: dyoung@redhat.com (Dave Young)
Date: Wed, 13 Jul 2016 16:36:32 +0800
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160713082639.GZ1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <87poqinf9m.fsf@linux.vnet.ibm.com>
 <20160713082639.GZ1041@n2100.armlinux.org.uk>
Message-ID: <20160713083632.GA14038@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> Now, going back to the more fundamental issue raised in my first reply,
> about the kernel command line.
> 
> On x86, I can see that it _is_ possible for userspace to specify a
> command line, and the kernel loading the image provides the command
> line to the to-be-kexeced kernel with very little checking.  So, if
> your kernel is signed, what stops the "insecure userspace" loading
> a signed kernel but giving it an insecure rootfs and/or console?

The kexec_file_load syscall was introduced for secure boot in the first
place. In case UEFI secure boot the signature verification chain only
covers kernel mode binaries. I think there is such problem in both normal
boot and kexec boot.

Thanks
Dave
