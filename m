From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 23 Aug 2018 17:01:11 -0500
Subject: [PATCH] rtc: sun6i: Use struct_size() in kzalloc()
In-Reply-To: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
References: <20180823185140.GA29028@embeddedor.com>
 <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
Message-ID: <7a213f7c-354c-06d5-7b14-fc69e9bb8a31@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/23/18 3:56 PM, Kees Cook wrote:

>>
>> -       clk_data = kzalloc(sizeof(*clk_data) + (sizeof(*clk_data->hws) * 2),
>> -                          GFP_KERNEL);
>> +       clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
>>         if (!clk_data) {
>>                 kfree(rtc);
>>                 return;
> 
> This looks like entirely correct to me, but I'm surprised the
> Coccinelle script didn't discover this. I guess the isomorphisms don't
> cover the parenthesis?
> 

Apparently.

If I manually remove the ()s, the cocci script successfully generates a patch.

--
Gustavo
