From: wg@grandegger.com (Wolfgang Grandegger)
Date: Thu, 12 May 2011 09:04:40 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <201105112331.47954.arnd@arndb.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<20110510112734.54160824@lxorguk.ukuu.org.uk>	<2BFFDAA0A0DE4820876E5549867938EC@subhasishg>
	<201105112331.47954.arnd@arndb.de>
Message-ID: <4DCB8688.7070400@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 11:31 PM, Arnd Bergmann wrote:
> On Tuesday 10 May 2011, Subhasish Ghosh wrote:
>>
>>>> Yes, In case if we allow the ALL implementation, it hogs the CPU.
>>>> In that case we do not need the PRU. The whole purpose of the PRU
>>>> is to offload the processor for any such implementations. 
>>>
>>> So the kernel presumably needs to switch between using the PRU and native
>>> according to the number of ids being requested at the time ?
>>
>> All the IDs are programmed into the PRU data RAM.
>> The Kernel receives interrupts based upon these IDs.
>> I could not clearly follow "PRU and native", could you please elaborate.
> 
> We would really like all CAN drivers to behave the same way. All other
> drivers are able to work without filters, so pruss_can should allow that
> too, even if it becomes a CPU hog at that time.
> 
> It seems to me that the pruss can implementation has one thing backwards:
> it assumes a specific usage model for CAN that it is trying to do offload
> for. However, that usage model is currently not even supported by Socket
> CAN. If I understand Wolfgang correctly, it is in fact considered an
> unwanted limitation of the pruss can driver, instead of a useful feature.

"Unwanted" is not the right word. I see it as a piece of CAN hardware
with some serious limitations and I doubt that it will make real CAN
users happy. But well, I might be wrong.

> If that interpretation is right, I would seriously recommend rethinking
> the design of the CAN firmware for pruss, so you can start doing something
> useful with the offload engine that fits into the Socket CAN API, or that
> would be a useful extension to Socket CAN that is also implementable in
> the kernel for all other drivers in a meaningful way.

It would be really nice if they could provide a better firmware. Anyway,
the generic CAN hardware filter interface we spoke about in a previous
mail would fit for the PRUSS CAN hardware as well. It just needs to be
implemented.

Wolfgang.
