From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 8 Aug 2018 16:10:28 -0700
Subject: qemu machine settings and root fs for armv8?
In-Reply-To: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
References: <CAKwvOdkGatK1HbXG0hDr=a1DtnoCXUbVppLdR6uN5tAKzKdDDQ@mail.gmail.com>
Message-ID: <CAKwvOdnA5OTcBuRVbcBv8oYHR-mU3+Ee_iFjqbHx4UQxVnpxtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 11:52 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I was wondering if folks had recommendations for testing armv8 kernels
> in qemu, such as what machine settings and if root fs images existed.
> I've been playing around with buildroot, but was curious if people had
> recipes they could share?

Following up, I found:
https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm64-kernel.md
helpful to build the rootfs using buildroot.

Then:

$ qemu-system-aarch64 -kernel arch/arm64/boot/Image -machine virt -cpu
cortex-a57 -hda rootfs.ext2 -append "console=ttyAMA0 root=/dev/vda"
-serial mon:stdio -m 512 -nographic

worked for me.
-- 
Thanks,
~Nick Desaulniers
