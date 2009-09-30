From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 01 Oct 2009 08:53:44 +1300
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>
Message-ID: <4AC3B748.5060904@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> The clock generation system in the ep93xx uses two external oscillator's
> and two internal PLLs to derive all the internal clocks.  Many of these
> internal clocks can be stopped to save power.
> 
> This introduces a "parent" hierarchy for the clocks so that the users
> count can be correctly tracked for power management.
> 
> The "parent" for the video clock can either be one of the PLL outputs
> or the external oscillator.  In order to correctly track the "parent"
> for the video clock calc_clk_div() needed to be modified.  It now
> returns an error code if the desired rate cannot be generated.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
