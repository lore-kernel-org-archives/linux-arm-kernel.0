From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 9 Feb 2017 10:14:35 -0800
Subject: [PATCH] [net-next] ARM: orion: fix PHYLIB dependency
In-Reply-To: <20170209172024.GE29882@lunn.ch>
References: <20170209150834.1158193-1-arnd@arndb.de>
 <20170209155751.GB29882@lunn.ch> <1967873.WpTcGj2Cy4@wuerfel>
 <20170209172024.GE29882@lunn.ch>
Message-ID: <d00cef40-ab92-a84f-2e4e-1f7867b5ee76@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 09:20 AM, Andrew Lunn wrote:
>> Adding a 'select' statement to something as broad as NETDEVICES sounds
>> really bad, it has a significant risk of introducing dependency loops
>> and may be confusing if you want to build a multiplatform config without
>> networking support (note that NETDEVICES in turn depends on NET, which
>> can also be disabled).
> 
> O.K, so overall it is not simple. So lets drop my idea.
>  
>> One possibility would be to have a special Kconfig symbol that controls
>> mdiobus_register_board_info() being present and have that symbol
>> force PHYLIB to never be "=m". Then we can either have no networking
>> support and no phylib, turning mdiobus_register_board_info() into a
>> stub, or we have the function built-in and reachable from the board
>> code.
> 
> FYI: Florian is working on splitting MDIO out of PHYLIB. There will be
> two separate symbols, so it will be possible to have MDIO without
> PHYLIB. When this happens, i expect mdiobus_register_board_info() will
> be in the MDIO part, not PHYLIB.

Yes that would be the plan.
-- 
Florian
