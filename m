From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 12:25:44 +0530
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <1b68c6791003142350t1a671bf0k4777d8d4df8c5ab7@mail.gmail.com>
References: <4B9DB99A.5040104@st.com>	
	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>	
	<4B9DD766.7010504@st.com>
	<1b68c6791003142350t1a671bf0k4777d8d4df8c5ab7@mail.gmail.com>
Message-ID: <4B9DD9F0.60603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2010 12:20 PM, jassi brar wrote:
> On Mon, Mar 15, 2010 at 3:44 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>> On 3/15/2010 10:48 AM, jassi brar wrote:
>>> On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>>>> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
>>>> line.
>>> how about set_irq_chained_handler ?
>>
>> I think it is not for this purpose. Better to use IRQF_SHARED in normal
>> request_irq. what do you say?
> Of course, that is preferred if possible, as Ben already suggested.
> Btw, is your case not similar to having a common UART interrupt for
> Uart-Rx,Tx,Err irq ?
> 

We are now discussing two different things i suppose.
First: We have a common line for all type interrupts on UART.
This is handled well by the drivers (say - amba-pl011.c), and so we don't really 
have a issue here.

Second: Now UART, SDIO, SPI, I2S all have a common interrupt line, this is what
we need to handle. For this IRQF_SHARED is a better way.
