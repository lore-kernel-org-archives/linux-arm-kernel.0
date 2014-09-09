From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 17:59:59 +0200
Subject: [PATCH v2 5/8] net: pxa168_eth: get and set the mac address on
 the Ethernet controller
In-Reply-To: <1410273848-24663-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410273848-24663-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <3876979.iyRVchmjb7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:44:05 Antoine Tenart wrote:
> When changing the MAC address, in addition to updating the dev_addr in
> the net_device structure, this patch also update the MAC address
> registers (high and low) of the Ethernet controller with the new MAC.
> The address stored in these registers is used for IEEE 802.3x Ethernet
> flow control, which is already enabled.
> 
> This patch also tries reading the MAC address stored in these registers
> when probing the driver, to use the MAC address set by the bootloader
> and avoid using a random one.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 

I think it would be good to allow overriding the address using a
'mac-address' property from DT. It's very easy to call
of_get_mac_address().

	Arnd
