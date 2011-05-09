From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Mon, 9 May 2011 19:09:37 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <034A6447E0D54737B5CEE009A4D20B37@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I am observing a RX FIFO sized data loss problem with my driver.

I observed that if I start the TX before the RX, then there are no errors,
but, if I start a TX after a RX, then I observe the error (FIFO sized data 
chunks missing).

Say, for example, if I use all three UARTS and on all three I start RX, then 
for every TX started I would observe
one error on all the RX data buffer.

So, if I start only two TX, then I will see only two errors on all the three 
RX UARTS.
