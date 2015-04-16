From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Apr 2015 08:19:43 +0200
Subject: some question about writel implement in arm platform
In-Reply-To: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
References: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
Message-ID: <3810108.M3CSfEDqyN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 April 2015 13:28:41 yoma sophian wrote:
> hi all:
> the implementation of writel in ARM is writel_relaxed() with barrier
> before (DSB + outer cache sync).
> 
> if the memory is device memory, shall we still need outer cache sync?

Yes.

> if the memory is normal normal, under what circumstance we will write
> it with writel.

For normal memory, you never use writel.

> As far as I know, the writel is used for register writing.

Correct.

	Arnd
