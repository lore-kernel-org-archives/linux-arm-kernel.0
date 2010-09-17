From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 17 Sep 2010 11:53:43 +0200
Subject: i.mx25 :trouble with serial flow hardware
In-Reply-To: <AANLkTikb56gj78izBMhG2kL-mFOis9L0zk_kCYN5Gk6H@mail.gmail.com>
References: <AANLkTikb56gj78izBMhG2kL-mFOis9L0zk_kCYN5Gk6H@mail.gmail.com>
Message-ID: <20100917095343.GB3119@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 15, 2010 at 05:38:58PM +0200, Olivier Barthel wrote:

> I think the problem is in the function imx_transmit_buffer of file
> imx.c when this function is called by imx_start_tx called by
> uart_handle_cts_change. It consumes a character in the ring buffer
> (tail=tail+1) before testing whether the buffer is empty (tail=head?)
> or not. In the next loop, the function detects 4095 items in the
> circular buffer.
> By moving the test before reading of ring buffer, the problem is
> apparently corrected.

Sounds reasonable. Can you send a patch? It is easier to review code.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100917/398b8913/attachment.sig>
