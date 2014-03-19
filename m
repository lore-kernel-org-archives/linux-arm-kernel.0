From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Mar 2014 13:33:03 +0100
Subject: [PATCH v6 1/4] [media] exynos-scaler: Add DT bindings for SCALER
 driver
In-Reply-To: <1929080.dnr9A8PU43@avalon>
References: <1395213196-25972-1-git-send-email-shaik.ameer@samsung.com>
 <4637278.9G3gGkQ5GA@avalon> <532985A9.8050101@samsung.com>
 <1929080.dnr9A8PU43@avalon>
Message-ID: <53298E7F.30603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 19/03/14 12:59, Laurent Pinchart wrote:
> On Wednesday 19 March 2014 12:55:21 Sylwester Nawrocki wrote:
>> > On 19/03/14 12:31, Laurent Pinchart wrote:
>>>> > >> +++ b/Documentation/devicetree/bindings/media/exynos5-scaler.txt
>>>> > >> 
>>>>> > >> > @@ -0,0 +1,24 @@
>>>>> > >> > +* Samsung Exynos5 SCALER device
>>>>> > >> > +
>>>>> > >> > +SCALER is used for scaling, blending, color fill and color space
>>>>> > >> > +conversion on EXYNOS[5420/5410] SoCs.
>>>>> > >> > +
>>>>> > >> > +Required properties:
>>>>> > >> > +- compatible: should be "samsung,exynos5420-scaler" or
>>>>> > >> > +			"samsung,exynos5410-scaler"
>>>>> > >> > +- reg: should contain SCALER physical address location and length
>>>>> > >> > +- interrupts: should contain SCALER interrupt specifier
>>>>> > >> > +- clocks: should contain the SCALER clock phandle and specifier pair
>>>>> > >> > for
>>>>> > >> > +		each clock listed in clock-names property, according to
>>>>> > >> > +		the common clock bindings
>>>>> > >> > +- clock-names: should contain exactly one entry
>>>>> > >> > +		- "scaler" - IP bus clock
>>> > > 
>>> > > I'm not too familiar with the Exynos platform, but wouldn't it make sense
>>> > > to use a common name across IP cores for interface and function clocks ?
>> > Certainly it would, I proposed that when the exynos clock controller
>> > driver was posted, quite long time ago. Unfortunately it wasn't followed
>> > up. One of serious reasons was that there are common drivers for
>> > multiple Samsung platforms (also the ones not reworked to support dt) and
>> > thus changing the clock names would be problematic - driver would still
>> > need to handle multiple clock names.
>> > But for this driver a common name like "gate" could be better IMHO.
>
> OMAP uses "ick" for the interface clock and "fck" for the function clock. Do 
> you think it would make sense to standardize on "fck" across SoC families ?

Not sure if it could be future proof, I guess where it isn't bound to other
issues and the names could be chosen freely - we could try to use standard
names. OTOH it could obfuscate things a bit. As far as Samsung platforms 
are concerned, the function clock names are usually in form of SCLK_[IP_NAME],
"sclk" seems to be an abbreviation of "special clock".
It is also not always clear which clock is the interface clock and which is
the function clock. The "special clocks" are generally referred to as the IP 
block clocks.

--
Regards,
Sylwester
