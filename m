From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 31 May 2013 20:56:58 +0800
Subject: [PATCH v1 1/2] ARM:prima2: move sirfsoc_of_rstc_init to
 .init_early
In-Reply-To: <51A89ACE.8030604@st.com>
References: <1369993439-24216-1-git-send-email-srinivas.kandagatla@st.com>
 <1369993501-24309-1-git-send-email-srinivas.kandagatla@st.com>
 <CAGsJ_4z65+SOCQM2XKmrda+5Hu9wRuZviSvW3As1ROa0SmdXqw@mail.gmail.com>
 <51A89ACE.8030604@st.com>
Message-ID: <CAGsJ_4zaW_y0VCxZzwoK5s-Mv+M9yFXWfWuiMJ_fG9qKqDG3uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/31 Srinivas KANDAGATLA <srinivas.kandagatla@st.com>:
> On 31/05/13 13:24, Barry Song wrote:
>>> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> hi Sriniva,
>> i think my "arm: prima2: move to generic reset controller driver
>> framework" fixs this too:
>> http://www.spinics.net/lists/arm-kernel/msg246206.html
> I did look at the patch, I think it will fix it.
>
> But the patch is still using arch_initcall directly, which means this
> call will be attempted by every SOC in multi_v7 kernel.
> This call can be easily hooked into machine descriptor.
> In that way only prima compatible machines will attempt to call this
> function in first place.

mine should fix panic as it returns 0 instead of using BUG(). but i do
think we should merge yours too to avoid redundant execution path.

>
> Do you know if the second issue of postcore init is fixed in any other
> patches.

no. i will test your v2.

>
> thanks,
> srini

-barry
