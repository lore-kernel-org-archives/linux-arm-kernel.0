From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 16:29:39 +0100
Subject: [PATCH] mmc: mmci: Increase max_segs from 16 to 128
In-Reply-To: <1320941422-1565-1-git-send-email-ulf.hansson@stericsson.com>
References: <1320941422-1565-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZMcD_XzgNYN=PFdt3H-LQxOh=YBbHSADauzgZ_8bMA5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 5:10 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> A significant increase (10-20%) in performance throughput for
> USB mass storage is the reason for incrementing the value.
> By some reason the USB driver allocates buffers which requires
> a scattergather list to contain a lot more than 16 elements to
> get optimal performance. This change sets the maximum elements
> to 128.
>
> Tests with large reads and large writes (100 MiB) show that the
> throughput increase is significant for write (10% for this test)
> but not for read. Tests are run on a Linux host with ext4 FS on
> the gadget mass storage device. The sg-len still exceeds 16 for
> the read tests but the performance gain is low or nothing.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I will try to compile the lot of MMCI patches from Russells
tracker and test on the PB1176 once it's there...

BTW I had to do some fixup (trivial) when I applied all the
patches from the patch tracker. Hopefully Russell can do the
same, else we'll just create a pull request with all of them or
something.

Thanks,
Linus Walleij
