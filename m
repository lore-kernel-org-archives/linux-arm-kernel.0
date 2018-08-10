From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 10 Aug 2018 09:00:57 +0300
Subject: qemu machine settings and root fs for armv8?
In-Reply-To: <CAKwvOdnaknwFshVAk=G0x44RxZyrMPp+O2yFBauAe9-3C4DpTQ@mail.gmail.com>
References: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
 <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
 <5d585df0-abbe-c95f-adff-c4c2e3962832@redhat.com>
 <CAKwvOdnaknwFshVAk=G0x44RxZyrMPp+O2yFBauAe9-3C4DpTQ@mail.gmail.com>
Message-ID: <871sb6bw12.fsf@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

Nick Desaulniers writes:
> On Thu, Aug 9, 2018 at 12:36 AM Laura Abbott <labbott@redhat.com> wrote:
>> I usually use a buildroot environment and just boot as an initramfs:
>
> I need to play around more with buildroot, but I'll bet that's an
> option to make a ramdisk instead of a full disk image?

The BR2_TARGET_ROOTFS_CPIO config option of Buildroot enables build of
.cpio archive which is suitable for use as initramfs/initrd. See under
'Filesystem images' -> 'cpio the root filesystem'.

In case you also build your kernel under Buildroot, then
BR2_TARGET_ROOTFS_CPIO would automatically make your kernel embed the
cpio initramfs (using the kernel CONFIG_INITRAMFS_SOURCE). With that, you
don't need to pass a separate -initrd option to qemu.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
