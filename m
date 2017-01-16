From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 16 Jan 2017 23:48:40 +0200
Subject: [PATCH 2/3] dts: teach newer i.MX machines to have the i.MX35
 type watchdog
In-Reply-To: <20170116204337.j67oeknraas7ryib@pengutronix.de>
References: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
 <20170109095039.11979-3-u.kleine-koenig@pengutronix.de>
 <CAOMZO5CjkW1SdSAcSOj8Uws-xjoh=iZ1Ey9dwBdOdBzQLS6h8w@mail.gmail.com>
 <20170116204337.j67oeknraas7ryib@pengutronix.de>
Message-ID: <0586b2cd-6cbb-2e8a-9cd6-d7220708931d@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 10:43 PM, Uwe Kleine-K?nig wrote:
> On Mon, Jan 16, 2017 at 04:35:26PM -0200, Fabio Estevam wrote:
>> On Mon, Jan 9, 2017 at 7:50 AM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>>> Only i.MX35 and newer feature a WMCR register that should be written to. Older
>>> SoCs hang when this address is written.
>>>
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Only a minor nit: Subject could: ARM: dts: imx: teach...
> 
> Ack. To reference the commit id of the first patch in the third I can
> prepare a branch to pull. There I'd fix the Subject. Shawn, is this OK?
> 

This is too early for changes, which are not reviewed by Linux watchdog masters.

As I emphasized multiple times in our discussions your series is organized
improperly, it has interdependencies between DTS and driver, it lacks
atomicity feature of a proper fix, in the middle it breaks backward compatibility
with old DTB, all that makes it impossible to send an atomic fix for linux-stable,
some of the changes are captured from mine ones without preserving the authorship
or even a reported-by credit.

--
With best wishes,
Vladimir
