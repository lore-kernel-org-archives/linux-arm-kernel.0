From: davem@davemloft.net (David Miller)
Date: Sat, 17 Dec 2016 11:35:48 -0500 (EST)
Subject: [PATCH] net: mvpp2: fix dma unmapping of TX buffers for fragments
In-Reply-To: <20161217162658.63bc2423@free-electrons.com>
References: <1481647995-7213-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20161217.102057.1497114610120684110.davem@davemloft.net>
 <20161217162658.63bc2423@free-electrons.com>
Message-ID: <20161217.113548.422416317077715115.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sat, 17 Dec 2016 16:26:58 +0100

> Yes, I was thinking of moving towards a single array, as it's indeed
> crazy to have three arrays for that. However, since it's a fix going
> into stable, I also wanted to keep it as simple/straightforward as
> possible and avoid refactoring other parts of the code.

By the same token, by adding a third array you are making the code
more complex, adding more error recovery paths, etc.

> If you however believe moving to one array should be done as part of
> the fix, I'll do this.

Please do.
