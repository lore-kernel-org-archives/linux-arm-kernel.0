From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 29 Jan 2013 16:35:50 +0100
Subject: [PATCH 1/5] net: mvmdio: unmap base register address at driver
 removal
In-Reply-To: <20130129163242.1df2caf5@skate>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-2-git-send-email-florian@openwrt.org>
 <20130129163242.1df2caf5@skate>
Message-ID: <5107EC56.2000703@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 04:32 PM, Thomas Petazzoni wrote:
> Dear Florian Fainelli,
>
> On Tue, 29 Jan 2013 16:24:04 +0100, Florian Fainelli wrote:
>> Fix the driver remove callback to unmap the base register address and
>> not leak this mapping after the driver has been removed.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> What about using devm_request_and_ioremap() instead, in order to get
> automatic unmap on error and in the ->remove() path?

Right now, you are using of_iomap() which eases the task of fetching the 
resource and getting an ioremap cookie, which I why I kept that.

>
> But maybe it won't work because this memory range is claimed both by
> the MDIO driver and the Ethernet driver itself. In that case, you could
> use devm_ioremap().
Then we would loose the facility of of_iomap(), but fair enough, it can 
be inserted as a patch in this serie.

Thanks
--
Florian
