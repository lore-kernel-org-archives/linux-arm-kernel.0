From: itooo@itooo.com (Greg)
Date: Fri, 19 Apr 2013 16:13:19 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <20130419131237.GC22440@1wt.eu>
References: <5171419C.2090003@itooo.com> <20130419131237.GC22440@1wt.eu>
Message-ID: <517150FF.9010806@itooo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/04/2013 15:12, Willy Tarreau a ?crit :
> Hi Greg,
>
> On Fri, Apr 19, 2013 at 03:07:40PM +0200, Greg wrote:
>> I'm facing a problem with ethernet transmission (reception -seems- to be
>> fine), at best is it slow (~90Mbps), at worst the kernel OOPSes at
>> various locations dealing with memory (tcp_v4_destroy_sock, free_block
>> and skb_put seen so far) and ends up crashing right after.
>> I'm simply using iperf to generate traffic and the system has been
>> stable for a while with Marvell's LSP so I can say with confidence the
>> hardware is pretty stable.
>>
> You need to get the following commit from mainline to fix this issue :
>
>     ee40a116ebf139f900c3d2e6febb8388738e96d0
>
Willy, thanks for your fast an accurate answer, this seems to solve the 
stability issue but not the performance issue.

Please look at this strange behavior : 1 iperf will only transmit at 
~100Mbps, 100 parallel iperf will transmit at ~950Mb. Reception is not 
an issue.
I'm thinking of a socket <-> txQ relationship that would limit 
transmission rate, but I have no idea on how this is implemented.

> PS: is it indiscrete to ask what board this is ?
I designed the board myself, if you already heard about it I'd be glad 
to know you told you about it ;-)

Cheers,
