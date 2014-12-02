From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 2 Dec 2014 16:00:40 +0000
Subject: [RFC PATCH] hw/arm/virt: Add support for NUMA on ARM64
In-Reply-To: <1417524986-9196-1-git-send-email-zhaoshenglong@huawei.com>
References: <1417524986-9196-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <CAFEAcA_yCF+HaYtDc_crm3eNncQZ9QQYSZonQwOZoTnKzwE_zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2014 at 12:56, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> Add support for NUMA on ARM64. Tested successfully running a guest
> Linux kernel with the following patch applied:
>
> - arm64:numa: adding numa support for arm64 platforms.
> http://www.spinics.net/lists/arm-kernel/msg365316.html
>
> Example qemu command line:
> qemu-system-aarch64 \
>     -enable-kvm -smp 4\
>     -kernel Image \
>     -m 512 -machine virt,kernel_irqchip=on \
>     -initrd guestfs.cpio.gz \
>     -cpu host -nographic \
>     -numa node,mem=256M,cpus=0-1,nodeid=0 \
>     -numa node,mem=256M,cpus=2-3,nodeid=1 \
>     -append "console=ttyAMA0 root=/dev/ram"

Thanks for sending this patch. Unfortunately I know very
little about NUMA so it's a bit difficult for me to
evaluate (would anybody else care to look at it?).
Nevertheless, it's on my list of patches to review;
ping me if I don't get to it within a week or two.

-- PMM
