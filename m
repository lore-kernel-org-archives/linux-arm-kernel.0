From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 4 Apr 2015 17:34:47 +0200
Subject: [PATCH] i2c: cadence: Handling Slave monitor mode
In-Reply-To: <9ef3c612-b803-4937-bb21-0fac03969f39@BN1AFFO11FD037.protection.gbl>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
 <20150402202909.GA3501@katana>
 <9ef3c612-b803-4937-bb21-0fac03969f39@BN1AFFO11FD037.protection.gbl>
Message-ID: <20150404153447.GA3808@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > So, it is kind of flooding the bus until the timeout? That is not a single zero
> > byte message.
> >
> It will not flooding the bus until the timeout. Once it fails to access the bus it will be ideal for 15 clock cycles. Master again retrying to access the
> Slave immediately after the 15 clock cycles (There is a register in the controller to set the retry value min: 0 cycles, max: 16 cycles).This process will repeat until
> The software timeout will happen (1000msec).

Compared to do one access only this is "kind of flooding", no?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/b0929c3c/attachment.sig>
