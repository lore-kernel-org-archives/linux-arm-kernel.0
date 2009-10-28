From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Wed, 28 Oct 2009 12:25:50 +0100
Subject: ep93xx Ethernet hangs!
In-Reply-To: <8e7afda70910280402r41e198cet6fc92817cd1c847f@mail.gmail.com>
References: <8e7afda70910280402r41e198cet6fc92817cd1c847f@mail.gmail.com>
Message-ID: <20091028112550.GH4179@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

El Wed, Oct 28, 2009 at 12:02:02PM +0100 Markus Kreidl ha dit:

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
> client retransmits one byte longe data to the  ep93xx board.
> 
> This game will be repeated till a data length of 65000 bytes is reached.
> 
> Problem:
> Sometimes this test can be done two times without any problems, but
> when a problem occur the client application is waiting for the
> retranmission of sent data package. Also the ep93xx board is not
> pingable from a third computer.

I also have problems with ethernet hangs on an edb9301 like
board. I still haven't been able to identify a consistent pattern of
when the hang occurs, in my case it usually takes several days. Taking
down the interface and bringing it up again 'resolves' the problem.

I havn't spent much time investigating the issue, as my current
project doesn't rely on the ethernet interface and it takes days to
'reproduce' it.

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

      The assumption that what currently exists must necessarily
        exist is the acid that corrodes all visionary thinking
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
