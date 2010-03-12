From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 12 Mar 2010 09:46:02 +0100
Subject: [PATCH 05/11] ST SPEAr: Added clock framework for SPEAr platform
	and machines
In-Reply-To: <4B98C371.7050500@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-6-git-send-email-viresh.kumar@st.com>
	<63386a3d1003102300q23ea536bje956f8d5c7e333a2@mail.gmail.com>
	<4B98C371.7050500@st.com>
Message-ID: <63386a3d1003120046g2f83ace7s150441daa8bd6892@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/11 Shiraz HASHIM <shiraz.hashim@st.com>:
> On 3/11/2010 12:30 PM, Linus Walleij wrote:
>> 2010/3/3 Viresh KUMAR <viresh.kumar@st.com>:
>> (...)
>>> + ? ? ? if (unlikely(clk->flags & RESET_TO_ENABLE))
>>> + ? ? ? ? ? ? ? val &= ~(1 << clk->en_reg_bit);
>>> + ? ? ? else
>>> + ? ? ? ? ? ? ? val |= 1 << clk->en_reg_bit;
>>> + ? ? ? writel(val, clk->en_reg);
>>
>> I don't understand one bit of this. (...)
>
> The intention to use RESET_TO_ENABLE flag is to generalize clock
> enable/disable across platforms.

I misread the entire thing, there was some bad parsing inside my head...
Sorry about this.

>> OMAP uses CPUfreq but that is really about the CPU. As it happens, all
>> their clk:s always change frequency at the same operating points as the
>> CPU. So they can have pre/post calls from CPUfreq in their code, but
>> this will not work with things like PrimeCells where other users of the cell
>> may not have operating points correlated with CPU operating points.
>>
>> (I'm not requesting you to solve this problem, more to be aware of it.)
>
> I think generally in embedded systems (at least in our case :) ) the CPU clock
> itself is not completly independent. It is generally tied with some system
> clock, which has an impact on bus and peripheral clocks. In that sense cpu freq
> would be a better mean to notify frequency change.
> In any case, clock framework don't intend to do it. It only need to reflect
> correct system state. Is this understanding correct?

Currently it's like that but I think clk really needs a frequency change
notification mechanism. I will have to deal with it some day I think :-/

Yours,
Linus Walleij
