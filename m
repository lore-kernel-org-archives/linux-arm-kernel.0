From: davem@davemloft.net (David Miller)
Date: Thu, 07 Dec 2017 14:14:14 -0500 (EST)
Subject: [PATCH net-next v3 0/2] net: thunderx: add support for PTP clock
In-Reply-To: <20171207.133932.904724095727636711.davem@davemloft.net>
References: <20171206133100.26436-1-aleksey.makarov@cavium.com>
 <20171207.133932.904724095727636711.davem@davemloft.net>
Message-ID: <20171207.141414.1589365570542864289.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Miller <davem@davemloft.net>
Date: Thu, 07 Dec 2017 13:39:32 -0500 (EST)

> From: Aleksey Makarov <aleksey.makarov@cavium.com>
> Date: Wed,  6 Dec 2017 16:30:56 +0300
> 
>> This series adds support for IEEE 1588 Precision Time Protocol
>> to Cavium ethernet driver.
> 
> Series applied, thank you.

Actually, this doesn't even compile, I'm reverting:

drivers/net/ethernet/cavium/common/cavium_ptp.c:64:20: error: redefinition of ?cavium_ptp_get?
 struct cavium_ptp *cavium_ptp_get(void)
                    ^~~~~~~~~~~~~~
In file included from drivers/net/ethernet/cavium/common/cavium_ptp.c:19:0:
drivers/net/ethernet/cavium/common/cavium_ptp.h:59:34: note: previous definition of ?cavium_ptp_get? was here
 static inline struct cavium_ptp *cavium_ptp_get(void)
                                  ^~~~~~~~~~~~~~
drivers/net/ethernet/cavium/common/cavium_ptp.c:84:6: error: redefinition of ?cavium_ptp_put?
 void cavium_ptp_put(struct cavium_ptp *ptp)
      ^~~~~~~~~~~~~~
In file included from drivers/net/ethernet/cavium/common/cavium_ptp.c:19:0:
drivers/net/ethernet/cavium/common/cavium_ptp.h:64:20: note: previous definition of ?cavium_ptp_put? was here
 static inline void cavium_ptp_put(struct cavium_ptp *ptp) {}
                    ^~~~~~~~~~~~~~
