From: daniel@zonque.org (Daniel Mack)
Date: Tue, 2 Feb 2016 14:15:28 +0100
Subject: [PATCH v2 1/3] Input: rotary-encoder - make use of devm_* to
 simplify .probe and .remove
In-Reply-To: <20160202130022.GX13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1454408678-6011-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09968.9050705@zonque.org> <20160202130022.GX13664@pengutronix.de>
Message-ID: <56B0ABF0.8010904@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2016 02:00 PM, Uwe Kleine-K?nig wrote:
> On Tue, Feb 02, 2016 at 12:56:24PM +0100, Daniel Mack wrote:
>> On 02/02/2016 11:24 AM, Uwe Kleine-K?nig wrote:
>>> For all operations called in .probe there are devm_* variants.
>>> (input_register_device is clever enough to be devm aware on its own.)
>>> This allows to get rid of the error unwind code paths in .probe and the
>>> complete .remove function.
>>
>> While at it, could you also convert this over to the gpiod_* API?
> 
> This is done in patch 3.

Ah, right. Missed that detail, sorry.


Daniel
