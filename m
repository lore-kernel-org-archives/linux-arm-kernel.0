From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Apr 2014 15:02:15 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140402080102.GK2931@tbergstrom-lnx.Nvidia.com>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <20140331200620.GA13881@kroah.com> <533ABCEC.8040701@codethink.co.uk>
 <20140402080102.GK2931@tbergstrom-lnx.Nvidia.com>
Message-ID: <533C0A57.50102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/14 10:01, Peter De Schrijver wrote:
> On Tue, Apr 01, 2014 at 03:19:40PM +0200, Ben Dooks wrote:
>> On 31/03/14 21:06, Greg KH wrote:
>>> On Mon, Mar 31, 2014 at 06:41:56PM +0200, Sylwester Nawrocki wrote:
>>>> This function adds a helper function to configure clock parents and rates
>>>> as specified in clock-parents, clock-rates DT properties for a consumer
>>>> device and a call to it before driver is bound to a device.
>>>>
>>>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>
>> [snip]
>>
>>> I don't understand why you need the driver core to initialize this one
>>> type of thing?  That should be in a driver, or in a class, or at worse
>>> case, the platform code.
>>>
>>> What makes clocks so "unique" here?
>>
>> I suppose the issue here is that a lot of drivers currently use
>> clocks and a number of systems have badly setup default clock trees
>> at start time.
>>
>> Mark Brown and others have argued that the management of clocks which
>> is common to all devices should not live in the driver.
> 
> Exactly, this data should be part of the clock provider DT nodes, not
> of the device nodes. 

Why not in the device nodes, when often this data is closely related
to a device ? I'd prefer to keep the ability to also specify it at
the consumer nodes. IMHO the DT binding would be more explicit and
less error prone this way. E.g. clock-rates may refer directly to the
consumer clocks, so why we should be specifying it for all devices in
a single DT node ?

Also I'm not sure if a fact that something shouldn't be handled in
a device driver necessarily means that related data shouldn't be put
in the device node.

It would be nice to hear more opinions, it seems now there is
roughly same number of proponents and opponents of each option.

--
Thanks,
Sylwester
