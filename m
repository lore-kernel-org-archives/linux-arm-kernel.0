From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 13 Jun 2010 15:00:59 +0100
Subject: [PATCH 1/3] ISL6271A voltage regulator support.
In-Reply-To: <201006131230.08408.marek.vasut@gmail.com>
	(sfid-20100613_113213_110193_0C520859)
References: <1276346679-2893-1-git-send-email-marek.vasut@gmail.com>
	<20100612172114.GA20610@opensource.wolfsonmicro.com>
	<201006131230.08408.marek.vasut@gmail.com>
	(sfid-20100613_113213_110193_0C520859)
Message-ID: <40F790AF-4BAF-4AA2-8438-C3365FBABB57@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 13 Jun 2010, at 11:30, Marek Vasut wrote:

> Dne So 12. ?ervna 2010 19:21:14 Mark Brown napsal(a):
>> On Sat, Jun 12, 2010 at 02:44:37PM +0200, Marek Vasut wrote:
>>> This device is very simple, it supports only one LDO. This single LDO is
>>> programmed over I2C to 16 possible voltages.
>> 
>> Google tells me that the device has three regulators on it - two LDOs
>> and one DCDC buck convertor:
>> 
>>   http://www.intersil.com/products/deviceinfo.asp?pn=ISL6271A
>> 
>> While the LDOs look like they have no software control it'd be best to
>> provide hookup for them, even if that's just a case of instantiating the
>> appropriate fixed voltage regulators.

> Is this necessary? I'd only increase the kernel size without any gain ... or am 
> I wrong ?

If devices are connected to the fixed supplies they still need to be told about
the connection so they can interact well with the regulator API.

There's also the fact that your description of the device in the changelog is
rather inaccurate - the device has three regulators, not just a single LDO, and
the regulator that is software controllable is a DCDC buck convertor not a LDO.

>> Also, are you sure this is a buck?  That's a specific technical term
>> usually only applied to DCDC regulators - LDOs are a different type of
>> regulator

> That's what's written in the ISL6271a TRM. On the first page, under the 
> "Features" section.

That says there is one buck and 2 LDOs and it rather looks like the software
controllable regulator is the buck.
