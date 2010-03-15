From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Mon, 15 Mar 2010 14:39:58 +0530
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <4B9DF2FF.3000706@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com> <4B9DF2FF.3000706@st.com>
Message-ID: <4B9DF966.6050504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armando,

On 3/15/2010 2:12 PM, Armando VISCONTI wrote:
>> Now, For this we need some interface or channel through which we provide
>> this information to kernel. This is what precisely i have done. The
>> channel i
>> provided is through Kconfig and the function "s300_configure", accepts
>> this bitmap and configures hardware.
>>   
> I'm not getting this point.

yes, Actually this is what we are saying. Seemingly the best option is
to do it during compilation time, except if we have some standard way
at booting.

> If you do it thru Kconfig still it would be fixed a compilation time.
> Do you agree or am I missing something?

yes, and if you see, should any one require it dynamically? Each user 
would have his own board with static devices. This configuration (of 
selecting multiplexed devices) depends on his board configuration, which
is the responsibility of the board configuration file.

> So, probably the correct way is passing peripheral selection information
> thru
> bootargs.
> What do you think?

This is very specific to how an SoC provides multiplexing options and will
vary greatly. Which option of bootargs are you talking about?

regards
Shiraz
