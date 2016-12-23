From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 23 Dec 2016 10:20:20 +0200
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
Message-ID: <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2016 03:55 AM, Guenter Roeck wrote:
> On 12/11/2016 03:21 AM, Vladimir Zapolskiy wrote:
>> On 12/11/2016 12:26 PM, Uwe Kleine-K?nig wrote:
>>> Hello Vladimir,
>>>
>>> On Sun, Dec 11, 2016 at 12:01:08PM +0200, Vladimir Zapolskiy wrote:
>>>> On 12/11/2016 11:35 AM, Uwe Kleine-K?nig wrote:
>>>>> On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
>>>>>> Power down counter enable/disable bit switch is located in WMCR
>>>>>> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
>>>>>> i.MX31 SoCs don't have this register. As a result of writing data to
>>>>>> the non-existing register on driver probe the SoC hangs up, to fix the
>>>>>> problem add more OF compatible strings and on this basis get
>>>>>> information about availability of the WMCR register.
>>>>>>
>>>>>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
>>>>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>>>>> ---
>>>>
> 
> 
> What is the ultimate conclusion of this exchange ?
> 
> Are we going to get another version of the patch, or did everyone agree that
> the patch is good as it is and does not require further changes ?
> 

I can not imagine a different fix.

--
With best wishes,
Vladimir
