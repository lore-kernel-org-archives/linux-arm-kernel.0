From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 11:58:51 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <20100315062041.GD31126@trinity.fluff.org>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
Message-ID: <4B9DD3A3.7050106@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,

On 3/15/2010 11:50 AM, Ben Dooks wrote:
>> > I have provided this selection from "make menuconfig", based on selection I
>> > configure hardware at initialization time. Basically these selections will
>> > decide which device is present in the system when it boots.
> This is really bad idea, what happens if you have a selection of
> boards with mutually-exclusive peripheral sets? Making these sorts of
> decisions at compile time is always a bad idea, it leaves people making
> distributitions a lot of extra work.
> 
> My first idea would be to add a function which is given a bitmap or
> list of devices to register, and this function sorts out what hardware
> bits to set as needed and then register if the selection is possible.
> 

I agree with your idea to pass a bitmap to kernel at some time
(probably at boot time), so that it can configure all required peripherals.

Now, For this we need some interface or channel through which we provide
this information to kernel. This is what precisely i have done. The channel i
provided is through Kconfig and the function "s300_configure", accepts this 
bitmap and configures hardware.

Isn't it correct?

regards,
viresh kumar.
