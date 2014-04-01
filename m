From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 1 Apr 2014 18:10:59 +0100
Subject: [PATCH] QEMU: ARM: boot: Load kernel at an Image friendly address
In-Reply-To: <1395718484-20424-1-git-send-email-joelf@ti.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
Message-ID: <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2014 03:34, Joel Fernandes <joelf@ti.com> wrote:
> Loading kernel at offset 0x10000 works only for zImage, but not for Image,
> because the kernel expect the start of decompressed kernel (.head.text) to be
> at an address that's a distance that's 16MB aligned from  PAGE_OFFSET +
> TEXT_OFFSET (see vmlinux.lds.S). This check is enfornced in __fixup_pv_table in
> arch/arm/kernel/head.S TEXT_OFFSET is 0x00008000, so a 16MB alignment needs to
> have a "0x8000" in the lower 16 bits so that they cancel out. Currently the
> offset Qemu loads it at is 0x10000.
>
> With zImage, this need is met because zImage loads the uncompressed Image
> correctly, however when loading an Image and executing directly Qemu is
> required it to load it at the correct location. Doing so, doesn't break Qemu's
> zImage loading. With this patch, both zImage and Image work correctly.
>
> Signed-off-by: Joel Fernandes <joelf@ti.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll put this in target-arm.next after 2.0 has released.

thanks
-- PMM
