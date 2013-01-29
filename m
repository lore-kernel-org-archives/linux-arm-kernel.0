From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 29 Jan 2013 18:16:02 +0100
Subject: [PATCH, RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <510802C3.7090803@wwwdotorg.org>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <510802C3.7090803@wwwdotorg.org>
Message-ID: <510803D2.4080603@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 06:11 PM, Stephen Warren wrote:
> On 01/29/2013 04:22 AM, Sascha Hauer wrote:
>> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>
>> This adds two little devicetree helper functions for determining the
>> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
>> the devicetree.
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>
>> The properties and their values have been taken from the fsl-mph-dr driver.
>> This binding is also documented (though currently not used) for the tegra
>> ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
>> This is a first attempt to parse these bindings at a common place so that
>> others can make use of it.
>>
>> Basically I want to know whether this binding is recommended for new drivers
>> since normally the devicetree uses '-' instead of '_', and maybe there are
>> other problems with it.
> 
> It's certainly typical to use - not _ for freshly defined properties.
> However, since this property already exists and is in-use, I don't think
> there's any choice but to maintain its current definition.
> 
> The code looked fine to me.

The code for phy_type is lifted from the ethernet guys and adopted to
the usb phy types.

"dr_mode" is, as Sascha pointed out, only used in
drivers/usb/host/fsl-mph-dr-of.c

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/4bde3299/attachment-0001.sig>
