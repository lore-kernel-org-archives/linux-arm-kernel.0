From: neidhard.kim@lge.com (Jongsung Kim)
Date: Tue, 21 May 2013 10:39:46 +0900
Subject: [PATCH] ARM: PL011: add support for extended FIFO-size of
 PL011-r1p5
References: <007301ce375e$bcf6d6b0$36e48410$@lge.com>
 <5191D200.3040604@wwwdotorg.org> <01fd01ce5072$d6b9fcd0$842df670$@lge.com>
 <5192A692.4010700@wwwdotorg.org> <022d01ce5107$8bc668e0$a3533aa0$@lge.com>
 <5193164E.6050400@wwwdotorg.org>
Message-ID: <007001ce55c4$139f96e0$3adec4a0$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jongsung Kim <neidhard.kim@lge.com> :
> Stephen Warren <swarren@wwwdotorg.org> :
>>> All r1p5 have 32-byte FIFO depth and it's not configurable. From the 
>>> PL011
>>> TRM:
>>> 
>>> r1p4-r1p5	Contains the following differences in functionality:
>>> 		* The receive and transmit FIFOs are increased to a depth of
32.
>>> 		* The Revision field in the UARTPeriphID2 Register on page
3-24
>>> 		  bits [7:4] now reads back as 0x3.
>>
>> Well, that certainly isn't true in practice. I think we should revert 
>> this commit until we can determine what the problem is.
>
> I asked to the ARM support about this. Waiting for reply..

ARM support said they doesn't have information about BCM2835 UART. Does
anyone have a communication channel to Broadcom? It takes time for me to
get contact point to Broadcom.. (I'm trying)

However, ARM support also said:

"If the Broadcom part definitely has 16-deep FIFOs, it cannot be based
on a PL011 r1p5, so I might guess that Broadcom have just referenced
the latest version of the documentation on our website, but have actually
implemented an earlier version."
