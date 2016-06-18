From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 18 Jun 2016 18:32:28 +0200
Subject: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
In-Reply-To: <20160512202755.GA3680@chewinlnx07.qualcomm.com>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
 <000701d1ab9d$df9b3100$9ed19300$@codeaurora.org>
 <934365f2bd30f242d8548e2a27483679@codeaurora.org>
 <20160512051347.GE8453@hector.attlocal.net>
 <20160512061843.GA6187@chewinlnx07.qualcomm.com>
 <20160512175830.GA32019@hector>
 <20160512193229.GA10499@chewinlnx07.qualcomm.com>
 <CAPBZ5QdD6knEzQVW-BAgRSMcd=Gqv9_1Xt2LNc+qWgtre_2ZXQ@mail.gmail.com>
 <20160512202755.GA3680@chewinlnx07.qualcomm.com>
Message-ID: <20160618163228.GG3017@tetsubishi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We run the command i2cdetect for address 0x3 to 0x77. The QUP generates
> write error for address 0x3 to 0x7 apart from other bus errors since
> these are reserved addresses. I was getting the crash in non DMA mode
> and BAM hang in DMA mode before putting the fix.
> 
> Also we have connected the I2C TPM and run the following script
> overnight for both DMA and Non DMA mode.  The script checks for
> all transfer length and we are generating multiple NACK and
> Non NACK error before each valid transfer.
> 
> a=1
> 
> while [ $a -lt 4096 ]
> do
>    echo $a
>    i2cdetect -y -a -r 0 0x03 0x77
>    tpm-manager get_random $a
>    i2cdetect -y -a -r 1 0x03 0x77
>    a=`expr $a + 1`
> done

So, what is the outcome of this discussion?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160618/51eabe63/attachment.sig>
