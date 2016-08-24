From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Wed, 24 Aug 2016 13:52:33 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <57bd7c72.94052e0a.c451a.684f@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 24, 2016 at 10:26:47PM +0100, Russell King - ARM Linux wrote:
> > The problem caused by my mistake, I was using the following kernel parameter:
> > mem=1048448k

> Try mem=1046M - reducing it by 2MB.  If that works, try mem=1047M
> instead.  Yes, that's more than you want to reserve, but please
> check how the system behaves with these.

I assume that you mean mem=1022M.

Quick testing results:
mem=256M works
mem=384M not
mem=524160k not (512M-128k)
mem=524228k works (512M-60k)
mem=512M works
mem=524348k not (512M+60k)
mem=524416k not (512M+128k)
mem=768M works
mem=896M not
mem=960M not
mem=1022M not
mem=1023M not
mem=1048000k not
mem=1048448k not (1024M-128k)
mem=1048514k not
mem=1048516k works (1024M-60k)
mem=1048518k works
mem=1048520k works
mem=1024M works

So I can reserve 0-60 kiB or 256 MiB but nothing between.
The device boots up with all listed values but cesa works with few
values only.

Best Regards
Jussi
