From: armando.visconti@st.com (Armando VISCONTI)
Date: Mon, 15 Mar 2010 11:10:20 +0100
Subject: QUERY: How to handle SOC Configuration (Peripheral	Multiplexing)
	in linux
In-Reply-To: <4B9DF966.6050504@st.com>
References: <4B9DB823.1040809@st.com>
	<20100315062041.GD31126@trinity.fluff.org>
	<4B9DD3A3.7050106@st.com> <4B9DF2FF.3000706@st.com>
	<4B9DF966.6050504@st.com>
Message-ID: <4B9E078C.4010706@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shiraz,

>> If you do it thru Kconfig still it would be fixed a compilation time.
>> Do you agree or am I missing something?
>>     
>
> yes, and if you see, should any one require it dynamically? Each user 
> would have his own board with static devices. This configuration (of 
> selecting multiplexed devices) depends on his board configuration, which
> is the responsibility of the board configuration file.
>   
This was also my understanding at the beginning.
But looking at the response from the community it
looks that it is better to have a single image for all boards
which is capable at runtime to be configured in the proper way.

>> So, probably the correct way is passing peripheral selection information
>> thru
>> bootargs.
>> What do you think?
>>     
>
> This is very specific to how an SoC provides multiplexing options and will
> vary greatly. Which option of bootargs are you talking about?
>   
Of course not a standard bootargs option.
I was more talking about a new specific option that is
passed thru bootargs and directed to a specific SPEAr function that
can apply the proper cfg and register setting, like someone (Ben?)
was suggesting.

In this option you should pass a bitmap or something like that.

Let me know your opinion on it.

Armando




Shiraz HASHIM wrote:
> Armando,
>
> On 3/15/2010 2:12 PM, Armando VISCONTI wrote:
>   
>>> Now, For this we need some interface or channel through which we provide
>>> this information to kernel. This is what precisely i have done. The
>>> channel i
>>> provided is through Kconfig and the function "s300_configure", accepts
>>> this bitmap and configures hardware.
>>>   
>>>       
>> I'm not getting this point.
>>     
>
> yes, Actually this is what we are saying. Seemingly the best option is
> to do it during compilation time, except if we have some standard way
> at booting.
>
>   
>> If you do it thru Kconfig still it would be fixed a compilation time.
>> Do you agree or am I missing something?
>>     
>
> yes, and if you see, should any one require it dynamically? Each user 
> would have his own board with static devices. This configuration (of 
> selecting multiplexed devices) depends on his board configuration, which
> is the responsibility of the board configuration file.
>
>   
>> So, probably the correct way is passing peripheral selection information
>> thru
>> bootargs.
>> What do you think?
>>     
>
> This is very specific to how an SoC provides multiplexing options and will
> vary greatly. Which option of bootargs are you talking about?
>
> regards
> Shiraz
>   


-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
