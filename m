From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 21 Mar 2015 10:09:52 +0100
Subject: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
In-Reply-To: <550CA6F8.7080504@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
 <550CA6F8.7080504@gmail.com>
Message-ID: <550D3560.8070802@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-03-15 00:02, Florian Fainelli wrote:
> On 18/03/15 18:23, Brian Norris wrote:
>> Supports up to two ports which can each be powered on/off and configured
>> independently.
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>> ---
>
> [snip]
>
>> +
>> +static const struct of_device_id brcmstb_sata_phy_of_match[] = {
>> +	{ .compatible	= "brcm,bcm7445-sata-phy" },
>
> The binding document specifies "brcm,phy-sata3" as a fallback compatible
> string, so we want to match it here.

Erm no we do not, what if another sata3 brcm phy comes along which
is not compatible, both would use "brcm,phy-sata3" as fallback / for
informational purposes, but we do not want this driver to be binding
to that other phy, which it would do with your suggestion.

Regards,

Hans
