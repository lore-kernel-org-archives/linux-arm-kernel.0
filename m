From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 11 Jun 2010 09:20:46 +0100
Subject: s3c-hsotg fixes
Message-ID: <1276244457-4072-1-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Some further fixes for the s3c-hsotg block, as well as a repost of
the missed USB phy clock setting patch which either got missed or
passed over from last time.

As a note, this series has a patch adding support for dedicated FIFO
mode, this is in my view a fix, as when the hsotg block is compiled
with dedicated fifos then each USB IN non-periodic pipe needs to be
alloacted a unique TX FIFO. We have no actual data on how well the
block performs when all IN TX NP FIFOs are all set to the same one,
but it really should be fixed.

I am not sure if I have been subscribed to linux-usb, please CC: me
just in case.

-- 
Ben
