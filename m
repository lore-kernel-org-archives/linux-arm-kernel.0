From: davem@davemloft.net (David Miller)
Date: Thu, 30 Oct 2014 12:17:10 -0400 (EDT)
Subject: net: fec: fix regression on i.MX28 introduced by rx_copybreak
 support
In-Reply-To: <20141030075104.05e44b43@ipc1.ka-ro>
References: <1414502584-10583-1-git-send-email-LW@KARO-electronics.de>
 <20141029.153430.1036004676442879956.davem@davemloft.net>
 <20141030075104.05e44b43@ipc1.ka-ro>
Message-ID: <20141030.121710.1524000348187962764.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>
Date: Thu, 30 Oct 2014 07:51:04 +0100

>> Also, I don't thnk your DIV_ROUND_UP() eliminate for the loop
>> in swap_buffer() is valid.  The whole point is that the current
>> code handles buffers which have a length which is not a multiple
>> of 4 properly, after your change it will no longer do so.
>>
> Do you really think so?

Yes, because you're rounding down so you'll miss the final
partial word (if any).
