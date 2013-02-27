From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 15:21:41 +0100
Subject: [PATCH 1/9] USB otg: use try_module_get in all usb_get_phy
 functions and add missing module_put
In-Reply-To: <512E105F.9010803@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
 <1361968035-18644-2-git-send-email-mkl@pengutronix.de>
 <20130227123132.GM8016@arwen.pp.htv.fi> <512DFED3.7070701@pengutronix.de>
 <20130227124333.GQ8016@arwen.pp.htv.fi> <512E001D.6060004@pengutronix.de>
 <20130227124739.GR8016@arwen.pp.htv.fi> <512E0247.8070808@pengutronix.de>
 <20130227134219.GC23652@arwen.pp.htv.fi> <512E105F.9010803@pengutronix.de>
Message-ID: <512E1675.7030700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 02:55 PM, Marc Kleine-Budde wrote:
> On 02/27/2013 02:42 PM, Felipe Balbi wrote:
>>> That'll be these 3 branches then:
>>>
>>> otg-for-v3.9 (bugfix for v3.9):
>>> 6bef020 USB otg: use try_module_get in all usb_get_phy functions and add missing module_put
>>>
>>> otg-for-v3.10 (depends on otg-for-v3.9):
>>> a0e17f5 USB: move bulk of otg/otg.c to phy/phy.c
>>> a6fc0d1 USB: add devicetree helpers for determining dr_mode and phy_type
>>> 8a4c9f8 USB mxs-phy: Register phy with framework
>>>
>>> chipidea-for-v3.10 (most patches depend on otg-for-v3.10):
>>> 15c930e USB chipidea: ci13xxx-imx: create dynamic platformdata
>>> 9466e85 USB chipidea: add PTW and PTS handling
>>> ad2cc0d USB chipidea: introduce dual role mode pdata flags
>>> 8e7f1bb USB chipidea i.MX: introduce dr_mode property
>>> 5d83722 USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy
>>
>> sounds good to me, please make sure to always split your series like
>> this. You can't expect me (or any maintainer for that matter) to pick
>> patches to proper branches based on your commit logs alone.
>>
>> remeber that every single maintainer needs to handle hundreds of emails
>> a week (if not a day) and if patches are properly split and cleanly
>> mention if it's a bugfix or not, things will go wrong.
> 
> That was just a proposal. You'll find these series in your inbox in a
> few minutes.

Done.

regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130227/e128f81e/attachment.sig>
