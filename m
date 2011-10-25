From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 25 Oct 2011 15:40:36 +0200
Subject: [PATCH] of: Add a reg-names property to name reg entries
In-Reply-To: <440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
References: <1319471697-8970-1-git-send-email-b-cousson@ti.com>
	<20111025082632.GJ4429@atomide.com>
	<440786C5-FA1C-4750-9990-0BA5AABC2190@kernel.crashing.org>
Message-ID: <4EA6BC54.7030007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2011 12:29 PM, Segher Boessenkool wrote:
>>> +		compatible = "ti,mcasp";
>>> +		reg =<0 0x10 0x10>,<0 0x20 0x10>,
>>> +		<1 0x10 0x10>,<1 0x20 0x10>;
>>> +		reg-names = "mpu", "dat",
>>> +			    "dma", "dma_dat";
>>
>> Hmm for some systems looks like this can also solve how to pass the
>> mux signal names cleanly from DT.
>
> What problem does any of this solve?  The device binding for the
> "mcasp" device will have to describe the possible "reg-names", and
> what those mean; but the binding already has to describe its "reg"
> property anyway.

What this solve is the ability to use the platform_get_resource_byname 
directly to retrieve the proper register base address. The binding is 
just a text description that the driver will not be able to use 
directly. It will have to get the resource using an abstract index.
It thus removes a level of indirection that is error prone and useless 
most of the time.

Benoit
