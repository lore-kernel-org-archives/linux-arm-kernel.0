From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 2 Apr 2015 22:29:09 +0200
Subject: [PATCH] i2c: cadence: Handling Slave monitor mode
In-Reply-To: <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
Message-ID: <20150402202909.GA3501@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> In slave monitor mode, the I2C interface is set up as a master and
> >> continues to attempt a transfer to a particular slave until the
> >> slave device responds with an ACK.
> >>
> >> Added this feature for zero length transfers enable the controller
> >> for slave monitor interrupt and get the status. Disable the slave
> >> monitor mode feature upon successful handling.
> >>
> >> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> >> Acked-by: Harini Katakam <harinik@xilinx.com>
> >
> > I am not sure this is going to work.
> >
> > How often is this access tried when there is no device? It should be
> > tried only once.
> 
> Once slave monitor is enabled in the host controller, it retries till there's an
> ACK or slave monitor is disabled. The SW wont be involved and need not

So, it is kind of flooding the bus until the timeout? That is not a
single zero byte message.

> be interrupted in this gap. The way this feature works in the controller though,
> I'm afraid there's no way to distinguish between no slave/ busy slave.
> The out is the software timeout in that case.
> Please suggest how to use this feature better.

I suggest to not use the feature and accept that this device cannot do
zero byte length messages.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150402/4c8d5c1f/attachment.sig>
