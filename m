From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 08 Apr 2011 10:56:20 +1200
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <alpine.LFD.2.00.1104071840430.28032@xanadu.home>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103112313.16128.arnd@arndb.de> <4D9DE532.5000802@linaro.org>
	<201104072329.24243.arnd@arndb.de>
	<4D9E30AE.9080105@bluewatersys.com>
	<alpine.LFD.2.00.1104071756080.28032@xanadu.home>
	<4D9E359D.50502@bluewatersys.com>
	<alpine.LFD.2.00.1104071840430.28032@xanadu.home>
Message-ID: <4D9E4114.3090102@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2011 10:45 AM, Nicolas Pitre wrote:
> On Fri, 8 Apr 2011, Ryan Mallon wrote:
> 
>> On 04/08/2011 10:01 AM, Nicolas Pitre wrote:
>>> On Fri, 8 Apr 2011, Ryan Mallon wrote:
>>>
>>>> On 04/08/2011 09:29 AM, Arnd Bergmann wrote:
>>>>> I'll try to capture the opinions from the other people as well,
>>>>> hopefully this represents a consensus. Please correct me otherwise.
>>>>>
>>>>> I believe the uncontroversial parts are:
>>>>>
>>>>> * Make it not an entry but a device with certain properties.
>>>>> * Make the naming so that you can have more than one of them.
>>>>> * Put all devices on an SoC that uses this scheme underneath that
>>>>>   device by setting their parents to the SoC device.
>>>>>
>>>>> For the location of the device, I have not seen a clear consensus yet,
>>>>> but I'm fine with eihter of these:
>>>>>
>>>>> /sys/devices/soc/${NAME}/
>>>>> /sys/devices/platform/soc${NUMBER}/
>>>>
>>>> I prefer the second format here since the path is always the same which
>>>> makes it easier to write parsing tools. The name should be an entry in
>>>> the directory rather than the name of the directory itself.
>>>>
>>>> Probably SoC number should match CPU number for SMP machines right?
>>>
>>> Not really.  SOC means System On Chip.  you usually have only one SOC on 
>>> a board, and within that SOC you may have one or more CPUs.  SMP 
>>> machines are still likely to have only one SOC.
>>
>> Ok. What is the situation where we have more than one SoC?
> 
> That would mean two separate instances of Linux, just like two systems.  
> SMP across multiple SOCs doesn't make much sense, and I don't think they 
> are likely to be designed for that ability either.

So we probably don't need the ability to have multiple SoC directories
under sysfs then?

For the other part of the question, do you think it makes sense for the
CPU's to be child devices of the SoC (and for the CPU devices to be
potentially symlinked from the SoC directory)?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
