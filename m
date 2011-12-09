From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 9 Dec 2011 14:24:05 +0000
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer
 sharing mechanism
In-Reply-To: <201112091413.03736.arnd@arndb.de>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <201112071340.35267.arnd@arndb.de>
 <CAKMK7uFQiiUbkU-7c3Os0d0FJNyLbqS2HLPRLy3LGnOoCXV5Pw@mail.gmail.com>
 <201112091413.03736.arnd@arndb.de>
Message-ID: <20111209142405.6f371be6@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I still don't think that's possible. Please explain how you expect
> to change the semantics of the streaming mapping API to allow multiple
> mappers without having explicit serialization points that are visible
> to all users. For simplicity, let's assume a cache coherent system

I would agree. It's not just about barriers but in many cases where you
have multiple mappings by hardware devices the actual hardware interface
is specific to the devices. Just take a look at the fencing in TTM and
the graphics drivers.

Its not something the low level API can deal with, it requires high level
knowledge.

Alan
