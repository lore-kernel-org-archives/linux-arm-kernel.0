From: haas@computerlinguist.org (Michael Haas)
Date: Sun, 1 May 2016 08:46:28 +0200
Subject: [linux-sunxi] Re: [PATCH 2/3] sunxi: A20-OLinuXino-LIME2: Add
 usb-power-supply
In-Reply-To: <20160402103648.GI4227@lukather>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-2-git-send-email-haas@computerlinguist.org>
 <20160402103648.GI4227@lukather>
Message-ID: <dec3f06a-1b27-8426-9119-fd7472e0a090@computerlinguist.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,


On 04/02/2016 12:36 PM, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Mar 25, 2016 at 08:04:06PM +0100, Michael Haas wrote:
>> The A20-OLinuXino-LIME2 uses the AXP209 PMIC. This patch adds the
>> corresponding usb-power-supply node to the DTS.
>> If CONFIG_AXP20X_POWER is set, this patch enables the /sys/class/power_supply/
>> diirectory.
>>
>> Signed-off-by: Michael Haas <haas@computerlinguist.org>
> 
> Is there *any* reason to not use the AXP209 dtsi where it's already
> defined?
> 

do you have any preference for this being in the AXP209 dtsi? I've been
thinking about it and it makes sense to enable the power supply nodes
for all devices using the AXP209. They will just report themselves as
offline if the PMIC indicates nothing is connected.

Best,

Michael


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160501/5dcb9301/attachment.sig>
