From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 25 Oct 2011 18:10:48 +0200
Subject: [PATCH] of: Add a reg-names property to name reg entries
In-Reply-To: <BC60AF8F-C329-44B9-BEC9-EA5821725E1B@kernel.crashing.org>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111025082632.GJ4429@atomide.com>
	<440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
	<4EA6BC54.7030007@ti.com>
	<BC60AF8F-C329-44B9-BEC9-EA5821725E1B@kernel.crashing.org>
Message-ID: <4EA6DF88.2080704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2011 4:17 PM, Segher Boessenkool wrote:
>>> What problem does any of this solve?  The device binding for the
>>> "mcasp" device will have to describe the possible "reg-names", and
>>> what those mean; but the binding already has to describe its "reg"
>>> property anyway.
>>
>> What this solve is the ability to use the
>> platform_get_resource_byname directly to retrieve the proper
>> register base address.
>
> You do not have to put it in the device tree for that, the device
> driver can implement this itself if it cares.

???

The driver is the user of that name, so it has to be populated before 
into the resource during device creation.

>> The binding is just a text description that the driver will not be
>> able to use directly. It will have to get the resource using an
>> abstract index.
>
> Your reg-names are abstract identifiers just as well.

This is the name used in the HW documentation.
Ordering them to get a number is purely arbitrary. That's why using the 
name will allow the driver to get the resource the way it is represented 
in the documentation and thus avoid some intermediate number.

>> It thus removes a level of indirection that is error prone and
>> useless most of the time.
>
> It *adds* a level of indirection.  I doubt it helps prevent errors
> either, but who knows.

Well, if that does not bring anything to you, you can just not use it.

Benoit
