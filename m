From: davem@davemloft.net (David Miller)
Date: Mon, 12 Jun 2017 10:59:05 -0400 (EDT)
Subject: [PATCH v2] net: phy: Make phy_ethtool_ksettings_get return void
In-Reply-To: <20170612.102525.1159274040679939960.davem@davemloft.net>
References: <20170612141508.29229-1-yuval.shaia@oracle.com>
 <20170612.102525.1159274040679939960.davem@davemloft.net>
Message-ID: <20170612.105905.1031273319008486521.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 10:25:25 -0400 (EDT)

> From: Yuval Shaia <yuval.shaia@oracle.com>
> Date: Mon, 12 Jun 2017 17:15:08 +0300
> 
>> Make return value void since function never return meaningfull value
>> 
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> ---
>> v0 ->v1:
>> 	* These files were missing in v0
>> 		* drivers/net/ethernet/renesas/ravb_main.c
>> 		* drivers/net/ethernet/renesas/sh_eth.c
>> 		* drivers/net/ethernet/ti/netcp_ethss.c
>> 	* Add Acked-by: Sergei Shtylyov
>> v1 -> v2:
>> 	* Adjust to net-next tree
> 
> Applied, thank you.

Reverted, please test your build properly:

drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c: In function ?xgene_get_link_ksettings?:
drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c:134:10: error: void value not ignored as it ought to be
   return phy_ethtool_ksettings_get(phydev, cmd);
          ^
drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c:140:11: error: void value not ignored as it ought to be
    return phy_ethtool_ksettings_get(phydev, cmd);
           ^
scripts/Makefile.build:302: recipe for target 'drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.o' failed
