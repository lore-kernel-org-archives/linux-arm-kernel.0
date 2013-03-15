From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 15 Mar 2013 13:51:01 +0100
Subject: [PATCH 0/4] mv643xx_eth: use mvmdio MDIO bus driver
In-Reply-To: <20130315.085321.1047694772636447477.davem@davemloft.net>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <20130315.085321.1047694772636447477.davem@davemloft.net>
Message-ID: <51431935.6060407@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/15/13 13:53, David Miller a ?crit :
> From: Florian Fainelli <florian@openwrt.org>
> Date: Thu, 14 Mar 2013 19:08:31 +0100
>
>> This patch converts the mv643xx_eth driver to use the mvmdio MDIO bus driver
>> instead of rolling its own implementation. As a result, all users of this
>> mv643xx_eth driver are converted to register an "orion-mdio" platform_device.
>> The mvmdio driver is also updated to support an interrupt line which reports
>> SMI error/completion, and to allow traditionnal platform device registration
>> instead of just device tree.
>>
>> David, I think it makes sense for you to merge all of this, since we do
>> not want the architecture files to be desynchronized from the mv643xx_eth to
>> avoid runtime breakage. The potential for merge conflicts should be very small.
>
> All applied to net-next, thanks.
>

Oh woah that was fast, maybe too fast, I will submit a follow-up patch 
for patch 4 to address the issues I mentionned earlier.
--
Florian
