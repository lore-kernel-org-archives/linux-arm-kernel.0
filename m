From: riku.voipio@linaro.org (Riku Voipio)
Date: Wed, 28 Jan 2015 13:42:55 +0200
Subject: arm32 binaries work with CONFIG_COMPAT as root but not as user?
In-Reply-To: <20150128112249.GD6646@e104818-lin.cambridge.arm.com>
References: <CAAqcGHnS7P7=xzXoOPE61dcbbq_1kvmeB-V1GcDUxB1ND0-kZA@mail.gmail.com>
 <20150128112249.GD6646@e104818-lin.cambridge.arm.com>
Message-ID: <CAAqcGHn5rVyWRznbgTxLjTp6kHRGWW26-zJ3t7eOki_czwx1AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2015 at 13:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jan 28, 2015 at 10:52:21AM +0000, Riku Voipio wrote:
> What does this say:
cat /proc/sys/vm/mmap_min_addr
65536

> # cat /proc/sys/vm/mmap_min_addr
>
> If it is 64K, it won't run 32-bit apps as non-root.

echo 32768 > /proc/sys/vm/mmap_min_addr

and indeed binaries work as expected.

The ubuntu LTS 3.13 kernel has:

/boot/config-3.13.0-39-generic:CONFIG_DEFAULT_MMAP_MIN_ADDR=65536

I need to check how the value ended up wrong on the 3.19-rc3 I tested.

> --
> Catalin
