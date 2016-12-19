From: romain.perier@free-electrons.com (Romain Perier)
Date: Mon, 19 Dec 2016 15:56:34 +0100
Subject: [PATCH 1/4] net: dsa: mv88e6xxx: Allow mv88e6xxx_smi_init() to be
 used at address 0x1
In-Reply-To: <20161219143848.GA10048@lunn.ch>
References: <20161219141610.30934-1-romain.perier@free-electrons.com>
 <20161219141610.30934-2-romain.perier@free-electrons.com>
 <20161219143848.GA10048@lunn.ch>
Message-ID: <292d4f15-c58b-3565-26ec-98a025b6adb3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Le 19/12/2016 ? 15:38, Andrew Lunn a ?crit :
> On Mon, Dec 19, 2016 at 03:16:06PM +0100, Romain Perier wrote:
>> Currently, the function mv88e6xxx_smi_init() returns -EINVAL if the bit
>> zero of sw_addr is 0x1. However, on some platforms, ethernet switches
>> are configured in Multi chip addressing mode and available at MDIO
>> address 0x1.
>
> Hi Romain
>
> What branch is this against? net-next?

Until last friday it was based onto next-20161216, I rebased onto the 
torvalds's tree this morning (so ~4.10-pre-rc1).

>
> Please see:
>
> https://www.spinics.net/lists/netdev/msg409156.html

Oh, it's already fixed, good. I did not see this patch :)

>
> It would be nicer to use Volodymyr, since it has been reviewed.


As the fix is already there, I will use it, sure.

Thanks,
Romain
