From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 8 Sep 2015 13:46:21 +0200
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <55D5C4AA.2000307@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-2-git-send-email-danindrey@mail.ru>
 <20150724092720.GA1597@katana> <55B210F4.6030700@mail.ru>
 <20150724105251.GA22787@katana> <55D5C4AA.2000307@mail.ru>
Message-ID: <20150908114621.GB15793@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Sorry for the long delay. I tried to analyze the issue. Attached patch works
> on AC100 (Misha Komarovsky helped me with testing).
> 
> Wolfram could you please try the patch with your environment?

No change, sadly. I don't get slave interrupts.

> Init function is called multuple times. If I2C controller works
> in slave mode, then driver must keep slave registers otherwise
> slave configuration will be reseted.

This patch does not tackle the main issue, though. There should not be a
"slave mode" for the controller. It can be a master and slave
simultaneously and should do the right thing depending on what's
happening on the bus. The Tegra2 manual I have says "The Master can
address the internal slave (for basic testing) or an external 7-bit or
10-bit addressed Slave device." So even a loopback should be possible
(if we trust the manual ;)).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150908/a63da796/attachment.sig>
