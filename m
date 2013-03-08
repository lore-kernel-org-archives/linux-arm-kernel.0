From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 08 Mar 2013 17:31:41 +0100
Subject: [PATCH 3/4] USB mxs-phy: use readl(), writel() instead of the
 _relaxed() versions
In-Reply-To: <20130308162807.GD32368@arwen.pp.htv.fi>
References: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
 <1362048751-4061-4-git-send-email-mkl@pengutronix.de>
 <87sj4gwuhi.fsf@ashishki-desk.ger.corp.intel.com>
 <513A0C66.8080307@pengutronix.de> <20130308162807.GD32368@arwen.pp.htv.fi>
Message-ID: <513A126D.5080906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 05:28 PM, Felipe Balbi wrote:
> Hi,
> 
> On Fri, Mar 08, 2013 at 05:05:58PM +0100, Marc Kleine-Budde wrote:
>> On 02/28/2013 12:25 PM, Alexander Shishkin wrote:
>>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>>>
>>>> This patch converts the mxs-phy driver from readl_relaxed(), writel_relaxed()
>>>> to the plain readl(), writel() functions, which are available on all platforms.
>>>> This is done to enable compile time testing on non ARM platforms.
>>>>
>>>> Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>
>>> I think it was Felipe who reported this actually.
>>
>> Fixed. I'm about to repost this series with crediting Felipe as reporter.
>>
>> Which tree would you like to be this series based on? It depends on the
>> "USB otg: use try_module_get in all usb_get_phy functions and add
>> missing module_put" patch which is part of your usb/fixes branch, but
>> not in usb/next yet.
> 
> look at my testing branch. I have them all already. You didn't get an
> email yet because I'm waiting for -rc2 to be tagged.

Thanks.

> I have fixed the Reported-by tag, no issues there.
> 
> Anyway, as soon as v3.9-rc2 is tagged, I will rebase testing on top of
> that and move all patches to 'next', then everything will be stable from
> that point on.
> 
> If you want to have changes to any of the patches, now is the time,
> after I move patches to 'next' the tree becomes immutable.

Nope, I just wanted to keep track of the patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/f1700416/attachment.sig>
