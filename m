From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 12 Jun 2013 11:45:37 +0100
Subject: [PATCH v2 02/11] clocksource:global_timer: Add ARM global timer
 support.
In-Reply-To: <CACRpkdbppRqnMYknbBy8JpAVtujMOEQvyczXTmpvkQuxgikFog@mail.gmail.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856087-6452-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdbQCRKBzRF4HzNsXHwXCLJJcFZ9T36GPmmYsnX1OfgGRg@mail.gmail.com>
 <51B5D7A6.1020101@st.com> <51B72E9A.6070006@st.com>
 <CACRpkdbppRqnMYknbBy8JpAVtujMOEQvyczXTmpvkQuxgikFog@mail.gmail.com>
Message-ID: <51B85151.2060409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/13 21:13, Linus Walleij wrote:
> On Tue, Jun 11, 2013 at 4:05 PM, Srinivas KANDAGATLA
> <srinivas.kandagatla@st.com> wrote:
> 
>> Doing this is not adding any value to the driver, because
>>  1. Currently the driver only support DT boot paths, in my previous RFC
>> patches, Arnd suggested to get rid of the header as all platforms are DT
>> now.
> 
> In that case why do you have the separate global_timer_init()
> at all? Just move that code into global_timer_of_register() and
> also remove the #ifdef around CONFIG_OF and make the driver
> depend on CONFIG_OF in Kconfig.
> 
> After this you realize that all that business with
> clk_register_clkdev() / clk_get_sys() is just pure surplus
> baggade, you just use of_clk_get() and that's it.

It makes sense to move all the code into global_timer_of_register().
This will also get rid of un-used code. I will do this in the next spin.

Thanks,
srini

> 
> Yours,
> Linus Walleij
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
