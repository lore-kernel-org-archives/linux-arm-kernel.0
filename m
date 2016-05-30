From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 May 2016 10:16:43 +0200
Subject: [PATCH v3] Axi-usb: Add support for 64-bit addressing.
In-Reply-To: <C89496FEAE474D468F30D558A9468D9F26CEEBAB@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1464067268-35299-1-git-send-email-navam@xilinx.com>
 <CAL_Jsq+VL6jjo5QLwnsC8rEfgP4KN5hCSB7QicWWN-uvZU0GHw@mail.gmail.com>
 <C89496FEAE474D468F30D558A9468D9F26CEEBAB@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <5333252.Un7tdhWc5Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 30, 2016 5:46:21 AM CEST Nava kishore Manne wrote:
> >
> The Axi-usb 5.00 IP is a FPGA based one. This IP needs to support two H/w designs one with 32 bit DMA addressing another one is 64 bit DMA addressing.
> And also in the software point for view we don?t have any register to figure out whether it is supporting 32 bit DMA addressing or 64 bit DMA addressing.
> To support both the designs I kept addrwidth property in the dt. I think here addrwidth property is make sense to differentiate the h/w configurations.
> If you want me to changes it to boolean please let me know I will fix it in the next version.

I think boolean would be more logical here, since what is configurable
here is not how many bits are supported, but whether the XUSB_DMA_DSAR_ADDR
register is present or not.

	Arnd
