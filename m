From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 07 Oct 2016 10:42:21 +0300
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <1475771380.22019.5.camel@mniewoehner.de>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com> <57C41582.1030604@linux.intel.com>
 <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
 <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
 <1475578687.1912.28.camel@mniewoehner.de>
 <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
 <1475771380.22019.5.camel@mniewoehner.de>
Message-ID: <87y420wqoy.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Michael Niew?hner <linux@mniewoehner.de> writes:
>> The clocks are same across working/non-working.
>> Is it possible to bisect the commit that's causing hang for 4.8x ?
>
>
> [c499ff71ff2a281366c6ec7a904c547d806cbcd1] usb: dwc3: core: re-factor init and exit paths
> This patch causes both the hang on reboot and the lsusb hang.

How to reproduce? Why don't we see this on x86 and TI boards? I'm
guessing this is failed bisection, as I can't see anything in that
commit that would cause reboot hang. Also, that code path is *NOT*
executed when you run lsusb.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161007/291447b6/attachment.sig>
