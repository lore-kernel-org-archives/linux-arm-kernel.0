From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Mon, 25 Aug 2014 20:28:21 +0900
Subject: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
In-Reply-To: <20140825112151.GA21336@amd>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd>
Message-ID: <53FB1DD5.3050207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2014 08:21 PM, Pavel Machek wrote:
> On Thu 2014-08-07 16:37:57, Jaehoon Chung wrote:
>> Since used the mmc_of_parse(), didn't parse the sub-node.
>> So we can remove the sub-node, because almost SoC used the only one card per a host.
>> And supports-highspeed can be replaced with "cap-mmc/sd-highspeed"
>> property.
> 
> Would it be better to fix parsing of the device tree, and not to
> change all the device trees?
> 
> Someone will want to do two slots sooner or later...
> 

First, I had considered that controller can be supported the multiple slot.
But MMC maintainers and other people suggested that consider the only one card per a host.
Two slots or more don't have any benefit, (power or performance, etc).

Best Regards,
Jaehoon Chung
