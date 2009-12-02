From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Wed, 2 Dec 2009 18:25:43 -0200
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <4B16C185.80905@warmcat.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
Message-ID: <37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 12/2/09, Andy Green <andy@warmcat.com> wrote:
>
> What did you do with your chip select line on the ULPI PHY?
>

I turn this line (CS_N) low before initializing ISP1504.

> The first iMX LiteKIT board I had was an old revision where they had
> tied the PHY chip select pin asserted.  The ULPI PHY acted braindamaged
> because glitchy junk from during poweron / reset was taken as real data
> and it never recovered during the session.
>
> Later versions of the LiteKIT changed this to be pulled deasserted and a
> GPIO can drive it asserted after reset is all done.  After I got a later
> revision with that mod, and drove the GPIO, suddenly all was well.
>

I was thinking it could be some hw issues, but this is not, because
using old kernel everything works fine.

Best Regards,

Alan
