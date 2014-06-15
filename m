From: xerofoify@gmail.com (Nick Krause)
Date: Sat, 14 Jun 2014 22:00:11 -0400
Subject: [PATCHV2]Fixes memory leak in clk-sunxi.c
In-Reply-To: <539CF77C.4010500@elopez.com.ar>
References: <1402794944-3357-1-git-send-email-xerofoify@gmail.com>
 <539CF77C.4010500@elopez.com.ar>
Message-ID: <CAPDOMVhjaMcuN3BnDtCXT7nLVDnsLvZJC7wyXMf8BqT16sRCJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Guys,
Good I just wanted to make sure it was fixed.
Cheers Nick


On Sat, Jun 14, 2014 at 9:31 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> Hi,
>
> El 14/06/14 22:15, Nick escribi?:
>
>> Signed-off-by: Nick <xerofoify@gmail.com>
>> ---
>>   drivers/clk/sunxi/clk-sunxi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index 6f4fc51..c2ce538 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -41,10 +41,10 @@ static void __init sun4i_osc_clk_setup(struct
>> device_node *node)
>>         const char *clk_name = node->name;
>>         u32 rate;
>>
>> -       if (of_property_read_u32(node, "clock-frequency", &rate))
>> +       if (of_property_read_u32(node, "clock-frequency", &rate)) {
>>                 kree(gate);
>>                 return;
>> -
>> +       }
>>         /* allocate fixed-rate and gate clock structs */
>>         fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
>>         if (!fixed)
>>
>
> There is no memory leak there, and I think the message was pretty clear when
> I mentioned it[1] and then Sergei mentioned it[2] twice[3]. As for the bug
> report[4] you linked in a private email, it has been closed as resolved by
> the original reporter.
>
> Cheers,
>
> Emilio
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263631.html
> [2]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263677.html
> [3]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263683.html
> [4] https://bugzilla.kernel.org/show_bug.cgi?id=59961
