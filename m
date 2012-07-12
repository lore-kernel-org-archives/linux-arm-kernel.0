From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 12 Jul 2012 09:44:11 +0530
Subject: Device tree binding for DVFS table
In-Reply-To: <20120711200402.GC2772@gmail.com>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk> <20120711200402.GC2772@gmail.com>
Message-ID: <4FFE4F13.2040402@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 July 2012 01:34 AM, Mike Turquette wrote:
> On 20120711-15:44, Mark Brown wrote:
>> On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
>>
>>> I'd expect a single property with freq/volt pairs or 2 properties for
>>> freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
>> I strongly agree - the current proposal is very hard to read due to the
>> separation between the voltage and frequency values.  Some devices do
>> also need to scale multiple rails together, especially when this gets
>> used for I/O devices.
>>
>> I'd also expect to see a range of voltages for each frequency rather
>> than a specific voltage; usually things are at least characterised with
>> a specified tolerance.
> Not only should we support multiple voltage rails but also multiple
> clocks.  For some devices a DVFS transition is composed of scaling
> multiple clock rates together.  So some sort of clock identifier
> (phandle?) is needed as well.  (forgive my ignorance on the phandle
> part, as I am a DT noob)

How about adding phandle of clock consumer node to frequency table?

> Regards,
> Mike
