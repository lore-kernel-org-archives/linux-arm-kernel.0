From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 08 Mar 2013 17:05:58 +0100
Subject: [PATCH 3/4] USB mxs-phy: use readl(), writel() instead of the
 _relaxed() versions
In-Reply-To: <87sj4gwuhi.fsf@ashishki-desk.ger.corp.intel.com>
References: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
 <1362048751-4061-4-git-send-email-mkl@pengutronix.de>
 <87sj4gwuhi.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <513A0C66.8080307@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2013 12:25 PM, Alexander Shishkin wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> writes:
> 
>> This patch converts the mxs-phy driver from readl_relaxed(), writel_relaxed()
>> to the plain readl(), writel() functions, which are available on all platforms.
>> This is done to enable compile time testing on non ARM platforms.
>>
>> Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> I think it was Felipe who reported this actually.

Fixed. I'm about to repost this series with crediting Felipe as reporter.

Which tree would you like to be this series based on? It depends on the
"USB otg: use try_module_get in all usb_get_phy functions and add
missing module_put" patch which is part of your usb/fixes branch, but
not in usb/next yet.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/94a68d9d/attachment-0001.sig>
