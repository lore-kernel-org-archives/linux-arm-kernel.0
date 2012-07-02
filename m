From: jason77.wang@gmail.com (Hui Wang)
Date: Mon, 2 Jul 2012 10:55:55 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20460.19712.158996.397146@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>	<1340853701-4488-3-git-send-email-shawn.guo@linaro.org>	<4FEC329C.7070004@pengutronix.de>	<20120628112111.GC22990@S2101-09.ap.freescale.net>	<4FEC400F.8010506@pengutronix.de>	<20120628114108.GD22990@S2101-09.ap.freescale.net>	<20460.18717.17688.965250@ipc1.ka-ro>	<20120628121302.GI22990@S2101-09.ap.freescale.net>
 <20460.19712.158996.397146@ipc1.ka-ro>
Message-ID: <4FF10DBB.1020106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa?mann wrote:
> Hi,
>
> Shawn Guo writes:
>   
>> On Thu, Jun 28, 2012 at 02:07:57PM +0200, Lothar Wa?mann wrote:
>>     
>>> Hi,
>>>
>>> Shawn Guo writes:
>>>       
>>>> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
>>>>         
>>>>> I mean which name is more precise, do these gpio enable/standy a "phy"
>>>>> or a "transceiver". For example:
>>>>> http://www.nxp.com/documents/application_note/AN00094.pdf, this document
>>>>> says: TJA1041/1041A high speed CAN transceiver.
>>>>>
>>>>>           
>>>> Isn't term "phy" (physical interface) generally meant to be the same
>>>> thing as "transceiver"?  I just happened to like the shorter one as
>>>> what Hui did in his patch.
>>>>
>>>> But it does not really matter to me, will change the name since you
>>>> care about it.
>>>>
>>>>         
>>> A transceiver is just a dumb piece of hardware, while a PHY contains
>>> some intelligence of its own.
>>>
>>>       
>> Then, it sounds more like a PHY than transceiver, since it's an IC
>> chip with some control over it.
>>
>>     
> The 'I' in 'IC' does not stand for 'intelligent', but for
> 'integrated'. ;)
> A can transceiver is usually merely a switchable buffer. There are no
> registers to configure it or an internal processor that does some
> magic.
>
>   
Sorry for reply late, in my first patch, i chose "phy" instead of "xcvr" 
because the MC33902 datasheet tell me it is a "high speed CAN physical 
interface", and it includes "an internal 5.0 V supply for the CAN bus 
transceiver".

And from the diagram in the page 1 of the MC33902 datasheet, the MC33902 
includes bus xcvr, i/o control logic, power supply and external 
regulator control logic. As a result i decided to use phy in the driver.

Regards,
Hui.
> Lothar Wa?mann
>   
