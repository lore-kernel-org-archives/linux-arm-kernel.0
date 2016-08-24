From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Aug 2016 14:38:55 +0200
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <57bd7c72.94052e0a.c451a.684f@mx.google.com>
References: <57bd7c72.94052e0a.c451a.684f@mx.google.com>
Message-ID: <20160824143855.72e43246@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 24 Aug 2016 13:52:33 +0300, radioconfusion at gmail.com wrote:

> I assume that you mean mem=1022M.
> 
> Quick testing results:
> mem=256M works
> mem=384M not
> mem=524160k not (512M-128k)
> mem=524228k works (512M-60k)
> mem=512M works
> mem=524348k not (512M+60k)
> mem=524416k not (512M+128k)
> mem=768M works
> mem=896M not
> mem=960M not
> mem=1022M not
> mem=1023M not
> mem=1048000k not
> mem=1048448k not (1024M-128k)
> mem=1048514k not
> mem=1048516k works (1024M-60k)
> mem=1048518k works
> mem=1048520k works
> mem=1024M works

The Mbus windows need to have a power of two size, and there are
windows going from the device to the CPU for devices doing DMA. If the
memory size is not a power of two, I'm not sure we're rounding up the
window size to the next power of two. That might be the issue here.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
