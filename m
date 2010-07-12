From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Mon, 12 Jul 2010 08:00:18 +0200
Subject: SAM9-L9260: TXD1 is not working on AT91SAM9260
In-Reply-To: <20100711210558.75ce662f@realm>
References: <4C381CCF.2050305@gmail.com> <20100711210558.75ce662f@realm>
Message-ID: <4C3AAF72.20604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergey,

Sergey Matyukevich wrote:
> Do you turn off hardware handshake when you configure 
> your test setup for ttyS2 ?

exactly this was the problem.
I reused my code that I wrote earlier for uart communication with
RTC/CTS, but then missed to turn hw handshaking off.
Hence all transmissions were being blocked.

Thank you for your hint, without it I might still be looking for the
problem in the wrong places.

cheers,
stefan
