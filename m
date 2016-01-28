From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:58:05 +0100
Subject: [PATCH 4/9] net: moxart: use correct accessors for DMA memory
In-Reply-To: <3468358.kXWNPLZEG9@wuerfel>
References: <1453903507-3427225-1-git-send-email-arnd@arndb.de>
 <063D6719AE5E284EB5DD2968C1650D6D1CCCEDCE@AcuExch.aculab.com>
 <3468358.kXWNPLZEG9@wuerfel>
Message-ID: <1907107.CbDFUn8Tsc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 January 2016 17:53:43 Arnd Bergmann wrote:
> 
> Makes sense. I looked at the ftmac100 driver, which is another driver
> for the same hardware, and it's also missing barriers. We should
> probably add them for both then.
> 

Nevermind. That one has write barriers, but no read barriers. I'm assuming
that this intentional and won't follow up with another patch for ftmac100.

	Arnd
