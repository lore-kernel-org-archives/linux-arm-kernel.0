From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 8 Feb 2015 12:03:25 +0100
Subject: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54D6EF3D.4030302@broadcom.com>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
 <20150207175039.GB6263@katana> <54D6EF3D.4030302@broadcom.com>
Message-ID: <20150208110325.GA2750@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Is it really a HW limitation? Could the driver later be extended to
> > continue filling the FIFO if a certain threshold is reached?
> > 
> 
> Will return -EOPNOTSUPP. This really depends on whether or not we expect
> one sequence of START + SLV ADDR + DATA + STOP per i2c message. I can
> later extend the driver to refill/re-drain the FIFO for data size >= 64
> bytes, if one sequence of SATRT...STOP per message is not a requirement.

It is important to have the terminology clear here: One transfer can
consist of multiple messages. The transfer uses START/STOP at the
beginning/end, the messages within the transfer only REPEATED_START.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150208/14e75449/attachment.sig>
