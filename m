From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 20 Jan 2016 08:02:17 +0100
Subject: iProc bus scanning regression (after "PCI: iproc: Add PAXC
 interface support")
In-Reply-To: <CACna6rx2t7Zg_xSVvYqZTW2dYEgRugaorV58Zy1YZ4Wy=+L4fQ@mail.gmail.com>
References: <CACna6rx2t7Zg_xSVvYqZTW2dYEgRugaorV58Zy1YZ4Wy=+L4fQ@mail.gmail.com>
Message-ID: <CACna6rzMK4Htci8AucHVi1TNjBkxdQiy60MWJ234J8=4B_vteA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2016 at 07:53, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> In OpenWrt trunk code we use iProc driver for PCIe controllers on bcma
> bus (PCIE_IPROC_BCMA). Right now we use 4.1 kernel but we backported
> all iProc changes. Unfortunately backporting set queued for 4.5 broke
> bus scanning on some routers.
>
> Most BCM4708 / BCM4709 chipsets have 3 PCIe controllers. All known
> routers use only first 2 of them. Even if router has 3 PCIe cards, the
> last two cards are connected to the 2nd PCIe controller.
>
> So that PAXC patch broke support for routers with 3 cards, 2 of them
> at the 2nd controller. It doesn't affect routers with just 2 cards.
> This problem was tracked down in:
> https://dev.openwrt.org/ticket/21393
>
> I'm attaching two OpenWrt boot logs.
> 1) r48381
> It contains all backported iProc changes. The log looks "nice", but
> only one card (0000:01:00.0) was detected.
> 2) r48382
> It contains "Revert "PCI: iproc: Add PAXC interface support"" patch.
> It contains many "[Firmware Bug]: reg 0x??: invalid BAR (can't size)"
> messages but there are all 3 cards detected: 0000:01:00.0,
> 0001:03:00.0 and 0001:04:00.0 (see brcmfmac messages).
>
> Can you take a look at this problem, please?

linux-arm-kernel@ stopped my e-mail due to its size. Sending
compressed attachments.

-- 
Rafa?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: openwrt-bcm53xx-netgear-r8000-squashfs.tar.bz2
Type: application/x-bzip2
Size: 18722 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/69dff3c2/attachment-0001.bz2>
