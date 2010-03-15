From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 12:36:09 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <20100315062041.GD31126@trinity.fluff.org>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
Message-ID: <4B9DDC61.3090609@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On 3/15/2010 11:50 AM, Ben Dooks wrote:
>> > I have provided this selection from "make menuconfig", based on selection I
>> > configure hardware at initialization time. Basically these selections will
>> > decide which device is present in the system when it boots.
> This is really bad idea, what happens if you have a selection of
> boards with mutually-exclusive peripheral sets?

In this case, we can have different defconfig files for different boards.

> Making these sorts of
> decisions at compile time is always a bad idea, it leaves people making
> distributitions a lot of extra work.
> 

I agree with this point but what is the other way for this.

Doing this at runtime will have following issue:

User have inserted a module and by mistake or lack of knowledge,
he disabled already working IP(due to multiplexing). Now with Kconfig concept 
this is taken care of at the beginning only. User can't select peripherals which
can't be enabled simultaneously.


regards,
viresh kumar.
