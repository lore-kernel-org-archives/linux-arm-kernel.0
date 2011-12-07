From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Dec 2011 13:06:47 +0100
Subject: [PATCH 00/14] mmc: mmci: Improved PM support, cleanup and bugfixes
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdZkqv+LW5nj4X9-sw+1kMWKbjQmZX_mECLx0Oq5o91JvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Mon, Dec 5, 2011 at 6:35 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Patch 1 -> 4:
> Minor changes for bugs and some performance optimizations.
> Previously sent to the mailing list.
> Patch 5 -> 7:
> Minor changes affecting how to handle a levelshifter.
> Previously sent to the mailing list.
> Patch 8:
> Bugfix for dma. Previously sent to the mailing list, ongoing discussion.
> Patch 9 -> 14:
> Improvement of PM support.

I applied all 14 patches on top of current v3.2-rc4
and regression-tested the whole shebang on RealView PB1176
and U300.

- Mounted /dev/mmcblk0p1
- Copy a kernel-sized uImage file from the card to ramdisk
- Copy the file back to the card from ramdisk
- Unmount
- Mount
- Compare the two files with diff (identical)
- Delete copy
- Unmount
- dd if=/dev/mmcblk0 of=/dev/null

(If any of you wants any more specific tests, tell me.)

Both platforms still work like a charm with these patches.
PB1176 is as slow on MMC as it always has been but dd:ed
the entire card without errors.

I have the branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git mmci

Ulf you can add my Tested-by: Linus Walleij <linus.walleij@linaro.org>
for these patches.

Russell if you want a pull request for a subset of the patches I can
arrange that, just tell me.

Yours,
Linus Walleij
