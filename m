From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 11 Dec 2013 08:06:36 +0100
Subject: [PATCH v1 1/6] net: mv643xx_eth: properly start/stop phy device
In-Reply-To: <20131210.215654.1165181423931409066.davem@davemloft.net>
References: <1386513631-11284-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386513631-11284-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131210.215253.2121948728095674632.davem@davemloft.net>
 <20131210.215654.1165181423931409066.davem@davemloft.net>
Message-ID: <52A80EFC.8070806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 03:56 AM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 10 Dec 2013 21:52:53 -0500 (EST)
>
>>
>> This series looks good, applied to net-next, thanks.
>
> Actually, I had to revert.
>
> You cannot use late_initcall_sync() from code that is potentially
> built modular, this caused my build to fail at the mdio_bus code.
>
> drivers/net/phy/mdio_bus.c:344:1: warning: data definition has no type or storage class [enabled by default]
> drivers/net/phy/mdio_bus.c:344:1: error: type defaults to ?int? in declaration of ?late_initcall_sync? [-Werror=implicit-int]
> drivers/net/phy/mdio_bus.c:344:1: warning: parameter names (without types) in function declaration [enabled by default]
> drivers/net/phy/mdio_bus.c:339:12: warning: ?mdio_bus_class_suspend_unused? defined but not used [-Wunused-function]
>

Hmm, I see. What about you drop patch 5 ("net: phy: suspend unused PHYs
on mdio_bus in late_initcall"), take the rest, and I'll have look at
suspending unused PHYs later?

Sebastian
