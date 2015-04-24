From: nm@ti.com (Nishanth Menon)
Date: Fri, 24 Apr 2015 14:38:39 -0500
Subject: [PATCH] bus: omap_l3_noc: Fix master id address decoding for OMAP5
In-Reply-To: <553A951A.1080905@ti.com>
References: <1429898060-51944-1-git-send-email-s-anna@ti.com>
 <553A8C68.5080903@ti.com> <553A951A.1080905@ti.com>
Message-ID: <CAGo_u6rgZhkRZSjpXuvBz5frYByUDtzFrAQFaPB7rxT8hLYBPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 2:10 PM, Suman Anna <s-anna@ti.com> wrote:
> On 04/24/2015 01:33 PM, Nishanth Menon wrote:
>> On 04/24/2015 12:54 PM, Suman Anna wrote:

...
>>> -static struct l3_target_data omap_l3_target_data_clk3[] = {
>>> -    {0x0100, "EMUSS",},
>>> -    {0x0300, "DEBUG SOURCE",},
>>> -    {0x0,   "HOST CLK3",},
^^ this was HOST CLK3


..
>>>
>>> +/* OMAP5 data */
>>> +static struct l3_target_data omap5_l3_target_data_clk3[] = {
>>> +    {0x0100, "L3INSTR",},
>>> +    {0x0300, "DEBUGSS",},
>>> +    {0x0,    "HOSTCLK3",},
>>
>> "HOST CLK"
>
> Why? I followed the convention used for the other two HOST CLKs for the

so asked, if it should be HOST<space>CLK3
--
Regards,
Nishanth Menon
