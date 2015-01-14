From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 Jan 2015 11:37:18 +0100
Subject: [PATCH v6] i2c: cadence: Check for errata condition involving
 master receive
In-Reply-To: <1421174099-19839-1-git-send-email-harinik@xilinx.com>
References: <1421174099-19839-1-git-send-email-harinik@xilinx.com>
Message-ID: <20150114103718.GA2615@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 12:04:59AM +0530, Harini Katakam wrote:
> Cadence I2C controller has the following bugs:
> - completion indication is not given to the driver at the end of
> a read/receive transfer with HOLD bit set.
> - Invalid read transaction are generated on the bus when HW timeout
> condition occurs with HOLD bit set.
> 
> As a result of the above, if a set of messages to be transferred with
> repeated start includes any message following a read message,
> completion is never indicated and timeout occurs.
> Hence a check is implemented to return -EOPNOTSUPP for such sequences.
> 
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>

Applied to for-next with some whitespace corrections, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/7ce2c64a/attachment.sig>
