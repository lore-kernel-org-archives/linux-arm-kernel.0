From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 6 Mar 2016 00:08:27 +0700
Subject: [PATCH] ARM: realview: DT support for the PBA8 and PBX-A9
In-Reply-To: <56D04CC2.9010708@arm.com>
References: <1456329276-29529-1-git-send-email-linus.walleij@linaro.org>
 <56D04CC2.9010708@arm.com>
Message-ID: <CACRpkdYBJ_4PbWoMK-wNwumuVaYPfxnxF1cw-01XyDU7rmD2jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 8:01 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> As with the Versatile AB I scored from a junk pile, trying to boot a
> full userspace from SD card makes slow progress through a storm of data
> transfer errors and eventually dies. USB is similarly flaky, with occasional
> device resets and command errors, but I don't see that it's this patch's
> fault

Neither SD/MMC or USB mass storage boots ever worked on these
shaky PL180 and ISP1760 drivers. Only NFS boot really works.

I think PL180 can be made to work if we implement a pure polling mode
(not IRQ, not DMA) to read it.

Yours,
Linus Walleij
