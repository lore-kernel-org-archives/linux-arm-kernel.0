From: davem@davemloft.net (David Miller)
Date: Sun, 24 Mar 2013 17:07:26 -0400 (EDT)
Subject: [PATCH 0/2] Fix for mv643xx_eth built as module
In-Reply-To: <201303242148.33842.florian@openwrt.org>
References: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
 <201303242148.33842.florian@openwrt.org>
Message-ID: <20130324.170726.2271831814087007906.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 24 Mar 2013 21:48:33 +0100

> Hello Simon,
> 
> Le dimanche 24 mars 2013 21:33:58, Simon Baatz a ?crit :
>> Recently [1], mv643xx_eth was changed to make use of mvmdio. However,
>> this change introduces two problems when mvmdio and mv643xx_eth are
>> built as modules:
>> 
>> - mvmdio is not loaded automatically by udev
>> - mv643xx_eth oopses when it can't find its PHY, i.e. when mvmdio is
>>   not yet loaded
>> 
>> The first problem can be fixed easily by adding a module alias for the
>> respective platform device.  The proposed fix for the second problem
>> uses EPROBE_DEFER as suggested by Thomas Petazzoni when the driver
>> can't find its PHY.
>> 
>> These patches apply on top of Florian Fainelli's patchset. They have
>> been tested on Marvel Kirkwood non-DT.
> 
> Both fixes look good to me, thanks for fixing this!
> 
> Acked-by: Florian Fainelli <florian@openwrt.org>

All applied, thanks.
