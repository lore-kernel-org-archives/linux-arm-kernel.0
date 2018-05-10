From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 May 2018 20:49:17 +0530
Subject: [PATCH V3] ARM: dts: da850-evm: use phandles to extend nodes
In-Reply-To: <CAHCN7xKXJnh5MSudY3FU_9Xw98PwDi3yaWTUdfjFDaE24NBrzw@mail.gmail.com>
References: <20180507123721.9264-1-aford173@gmail.com>
 <ae8292b2-b167-7a96-70be-1cfea6059874@ti.com>
 <CAHCN7xKXJnh5MSudY3FU_9Xw98PwDi3yaWTUdfjFDaE24NBrzw@mail.gmail.com>
Message-ID: <7692ca00-3c9d-6e3e-12b6-f65d82f6fa95@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2018 08:38 PM, Adam Ford wrote:
> On Thu, May 10, 2018 at 4:10 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Monday 07 May 2018 06:07 PM, Adam Ford wrote:
>>> Many node labels in the device tree (like serial0, serial1, etc) are being
>>> redefined, so let's modernize the device tree by using phandles to
>>> extend the existing nodes.  This helps reduce the whitespace.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>
>> I applied this without the pmic changes. I am not convinced about those.
>> The tps node is already being referred to as phandle. I am not sure
>> referring to each individual regulator using phandle is needed. Other
>> files like am335x-evm.dts don't do it as well.
> 
> I tested the regulator values and names after booting to see if the
> names and values matched the expected values. They did, so I am
> fairly confident it would have worked.

Not doubting that. But I am not sure if thats the "norm". Do you see any
other device-tree file doing this?

> 
>>
>> Another thing is whether we really need the tp6507x.dtsi file. It does
>> not seem to contain much and also da850-evm.dts is the only file
>> including it. So it seems pretty pointless to me.
> 
> Do you want me to do a patch that removes the  tp6507x.dtsi file and
> just sets up the
> PMIC from scratch within the da850-evm file?

I am fine with the plan, but not something urgent, IMO.

> 
>>
>> Here is what I committed.
> 
> Thank you.  I think looks cleaner this way, and more consistent with
> many of the other platforms and boards.

Yes.

Thanks,
Sekhar
