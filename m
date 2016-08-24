From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Wed, 24 Aug 2016 12:15:07 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <57bd659d.0f4d190a.e025.5da4@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 19 Aug 2016 16:09, Roman Perier wrote:
> Could you test with uImage.armada-385-db-ap [1], that's a legacy Image.
> Also, I have uploaded a minimalistic rootfs [2], if you want.
>
> 1. http://www.free-electrons.com/~romain/pub/cesa/uImage.armada-385-db-ap
> 2. http://www.free-electrons.com/~romain/pub/cesa/rootfs.cpio.xz

Huge thanks to Roman, Thomas and Russell.
The cesa works on your image and rootfs. Now it works on my system too.

The problem caused by my mistake, I was using the following kernel parameter:
mem=1048448k
My device has 1 GiB of RAM and I tried to reserve 128 kiB of memory for ram
oops. I guess this parameter caused overlapping or inaccessible area with cesa's
addresses. Am I right?
I tried to add memmap=0x20000$0x3ffe0000 without success.

Is this normal behaviour?
If yes, what is the right way to reserve RAM without killing the cesa? Should I
reserve memory at physical start point?

Best Regards,
Jussi
