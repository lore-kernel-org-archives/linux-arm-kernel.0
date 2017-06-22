From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Jun 2017 10:07:30 +0200
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170622074831.GA23753@dragon>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250> <20170620074126.GA1541@katana>
 <20170622074831.GA23753@dragon>
Message-ID: <20170622080730.o352kxrs5pz7wxnf@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> The audio codec is on address 0x22.
> 
> Why do you think it should be broken now?

Because I thought that we skipped the error handling for every transfer
when we removed the call to reset_hardware from the xfer function.

So, either it still works because the transfer times out. But then
i2cdetect should be really slow. The timeout is set to 1s, so it should
take 1s to scan every address.

Or I am completely missing something. Then, I am sorry for the noise.

Thanks for testing anyhow!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170622/4dc2b97f/attachment.sig>
