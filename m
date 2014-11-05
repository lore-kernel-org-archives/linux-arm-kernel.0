From: davem@davemloft.net (David Miller)
Date: Wed, 05 Nov 2014 15:52:07 -0500 (EST)
Subject: net: fec: fix regression on i.MX28 introduced by rx_copybreak
 support
In-Reply-To: <20141105062148.2a997b95@ipc1.ka-ro>
References: <20141104112912.2be8bf1a@ipc1.ka-ro>
 <20141104.112858.356827532569349127.davem@davemloft.net>
 <20141105062148.2a997b95@ipc1.ka-ro>
Message-ID: <20141105.155207.760255373450633226.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lothar Wa?mann <LW@KARO-electronics.de>
Date: Wed, 5 Nov 2014 06:21:48 +0100

> David Miller wrote:
>> Because it goes "(n + (d - 1)) / d"
>> 
>> Which for 'd' of 4 gives:
>> 
>> 1 --> 4
>> 2 --> 4
>> 3 --> 4
>> 4 --> 4
>>
> '1', not '4'.
> The loop has to be done once for each (probably partial) WORD of input
> data, not for each BYTE.

You're right, thanks for being so patient with me.

Please repost your patch, I'll integrate it.

Thanks.
