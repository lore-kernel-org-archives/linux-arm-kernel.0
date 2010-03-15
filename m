From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 15 Mar 2010 15:50:24 +0900
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DD766.7010504@st.com>
References: <4B9DB99A.5040104@st.com>
	<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>
	<4B9DD766.7010504@st.com>
Message-ID: <1b68c6791003142350t1a671bf0k4777d8d4df8c5ab7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 3:44 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
> On 3/15/2010 10:48 AM, jassi brar wrote:
>> On Mon, Mar 15, 2010 at 1:37 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>>> In our SOC (SPEArxxx), we have few peripherals which share common interrupt
>>> line.
>> how about set_irq_chained_handler ?
>
> I think it is not for this purpose. Better to use IRQF_SHARED in normal
> request_irq. what do you say?
Of course, that is preferred if possible, as Ben already suggested.
Btw, is your case not similar to having a common UART interrupt for
Uart-Rx,Tx,Err irq ?
