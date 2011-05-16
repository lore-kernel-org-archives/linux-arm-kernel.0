From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 16 May 2011 10:15:36 +0530
Subject: [QUERY] amba/pl022: DMA channel allocation always fail.
In-Reply-To: <BANLkTinMH9TpTTzqoMPS7JZUBRss3pScWg@mail.gmail.com>
References: <4DCD1D80.7060409@st.com>
	<BANLkTinMH9TpTTzqoMPS7JZUBRss3pScWg@mail.gmail.com>
Message-ID: <4DD0ABF0.3020707@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2011 08:01 PM, Linus Walleij wrote:
> 2011/5/13 viresh kumar <viresh.kumar@st.com>:
> 
>> amba/pl022 and my dma driver dw_dmac.c, both have registered init() routines
>> with subsys_initcall(). Now at bootup, spi boots up before DMA and so DMA
>> channels are never available at spi probe.
>>
>> What should be done to solve this issue?
> 
> If you check drivers/dma/ste_dma40.c you can see that our solution was to
> simply move the DMA engine to arch_initcall().
> 
> Which sort of makes sense for a DMA engine.
> 
> Does this work for dw_dmac.c?

Yes, it worked here too..

-- 
viresh
