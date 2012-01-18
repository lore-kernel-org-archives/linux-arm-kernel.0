From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 18 Jan 2012 16:10:51 +0530
Subject: [PATCH 2/8] dmaengine: Add flow controller information to
 dma_slave_config
In-Reply-To: <CACRpkdbwZ5h15b0gBJP6xdk5TJt+CSeNRbEB8o2vzp9FbyD9AA@mail.gmail.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326707233.git.viresh.kumar@st.com>
 <CACRpkdY4QQK6wtB5aPU+FwdyyGq-owsDxMmxdwJVnkzdJTRs_Q@mail.gmail.com>
 <4F153A3A.7060902@st.com>
 <CACRpkdbwZ5h15b0gBJP6xdk5TJt+CSeNRbEB8o2vzp9FbyD9AA@mail.gmail.com>
Message-ID: <4F16A1B3.5000409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/18/2012 4:06 PM, Linus Walleij wrote:
> On Tue, Jan 17, 2012 at 10:07 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
>> On 1/17/2012 2:07 PM, Linus Walleij wrote:

> Maybe I should say that it's supposed to transfer information from
> the driver to the DMA engine that:
> 
> 1) The driver naturally "knows", like which physical register address
>   the FIFO is in or burst width etc and the DMA engine has no
>   business knowing.
> 
> 2) That needs to change at runtime, like for example how the PL022
>  driver request 32, 16 or 8 bit wide transfers depending on bus
>  width.
> 
> I think master mode could very well be under (1). So the driver knows
> if this hardware expects the DMA engine to drive the transaction or
> if it's the device itself that should drive it.
> 
> So I'm starting to think like you :-)

:)

>> One more thing. I missed few things in this patch:
>> - Need to update all instances of struct dma_slave_config with
>>        .device_fc = false
> 
> All statically defined structs contain zero == false by default
> so it's not needed.
> 
> Make sure any dynamic allocations (I don't know of any!)
> are kzalloc() though.
> 

I already fixed these in V2.
Most of the drivers created inside routines. They are not getting
initialized to _zero_ , so i had to fix it.

There are few though, who used kzalloc. I didn't touch them.

-- 
viresh
