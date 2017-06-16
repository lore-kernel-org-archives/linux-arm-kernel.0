From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 16 Jun 2017 09:14:36 +0200
Subject: [PATCH V2 0/5] phy: bcm-ns-usb3: add MDIO driver
In-Reply-To: <a28bd799-abc2-8f4e-c3db-b9f82f35295a@ti.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170608200428.9187-1-zajec5@gmail.com>
 <a28bd799-abc2-8f4e-c3db-b9f82f35295a@ti.com>
Message-ID: <30100fc8-7538-fd30-0a6a-665019b38c38@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2017 08:36 AM, Kishon Vijay Abraham I wrote:
> On Friday 09 June 2017 01:34 AM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> As explained in the commit 9200c6f177638 ("Revert "phy: Add USB3 PHY support
>> for Broadcom NSP SoC"") this module should be modified to use MDIO bus as
>> this is how PHY is really attached.
>>
>> This should allow reusing this driver on NSP and any other platform with
>> MDIO bus and this particular PHY.
>
> can you run checkpatch and fix all warnings in this series?

I always check my patches before sending. For this set the only warning I
get is:

WARNING: line over 80 characters
#117: FILE: drivers/phy/broadcom/phy-bcm-ns-usb3.c:224:
+                                   usecs_to_jiffies(BCM_NS_USB3_MII_MNG_TIMEOUT_US));

I've problem finding a nice way of fixing this.
1) I can't break the line between arguments as there is only 1 argument
2) I shouldn't use small indention as it would misalign this line
3) Using tmp var for BCM_NS_USB3_MII_MNG_TIMEOUT_US sounds a bit pointless

According to the coding-style.rst having 80+ chars lines is acceptable if it
"significantly increases readability and does not hide information". Maybe
we can just live with this single line like that? Isn't this a bit bike
shedding in this case?
