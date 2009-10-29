From: markus.kreidl@gmail.com (Markus Kreidl)
Date: Thu, 29 Oct 2009 09:25:07 +0100
Subject: ep93xx Ethernet hangs!
In-Reply-To: <8e7afda70910280402r41e198cet6fc92817cd1c847f@mail.gmail.com>
References: <8e7afda70910280402r41e198cet6fc92817cd1c847f@mail.gmail.com>
Message-ID: <8e7afda70910290125x2c4a7308k53f07a8cfba62792@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correction test result: The ep93xx board is still pingable.

I tried the test without a hub or switch, I just used a
cross over cable between my PC and the ep93xx board to
avoid loosing packages.


2009/10/28 Markus Kreidl <markus.kreidl@gmail.com>:
> Hi,
>
> I am using a 2.6.30.4 kernel for my ep93xx ts-7260 board.
>
>
> Test scenario:
>
> I wrote a udp server/client application to test the ethernet
> interface. The server is implemented in the ep93xx board.
>
> a) the client connects to the ep93xx board and starts to send data
> (length 100bytes) to the ep93xx board and waits for same data to be
> retransmitted.
>
> b) ep93xx board receives the data and sends it back to the client.
>
> c) After the client receives the same data retransmitted data, the
> client retransmits one byte longe data to the ?ep93xx board.
>
> This game will be repeated till a data length of 65000 bytes is reached.
>
> Problem:
> Sometimes this test can be done two times without any problems, but
> when a problem occur the client application is waiting for the
> retranmission of sent data package. Also the ep93xx board is not
> pingable from a third computer.
>
>
> The same effect on kernel 2.6.27.10
>
> Hints are welcome.
>
> Markus K.
>
