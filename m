From: davem@davemloft.net (David Miller)
Date: Thu, 29 Dec 2016 12:03:37 -0500 (EST)
Subject: [PATCHv2 net-next 00/11] net: mvpp2: misc improvements and
 preparation patches
In-Reply-To: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20161229.120337.1969688544622629585.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Wed, 28 Dec 2016 17:45:56 +0100

> This series contains a number of misc improvements and preparation
> patches for an upcoming series that adds support for the new PPv2.2
> network controller to the mvpp2 driver.
> 
> The most significant improvements are:
> 
>  - Switching to using build_skb(), which is necessary for the upcoming
>    PPv2.2 support, but anyway a good improvement to the current mvpp2
>    driver (supporting PPv2.1).
> 
>  - Making the driver build on 64-bit platforms.
> 
> Changes since v1:
> 
>  - This series is split as a separate series from the larger patch set
>    adding support for PPv2.2 in the mvpp2 driver, as requested by
>    David Miller.
> 
>  - Rebased on top of v4.10-rc1.

You still have warnings to fix for the 64-bit build:

drivers/net/ethernet/marvell/mvpp2.c: In function ?mvpp2_rx?:
drivers/net/ethernet/marvell/mvpp2.c:5125:10: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   data = (void *)rx_desc->buf_cookie;
          ^
