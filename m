From: xerofoify@gmail.com (Nick Krause)
Date: Sun, 15 Jun 2014 23:31:41 -0400
Subject: [PATCH] Frees gate after if statement in clk-sunxi.c
In-Reply-To: <CAPDOMVj0JSp-ZfvAXkeTqHscKkhmp0ZttN5NVM+BYE_X+jWCcQ@mail.gmail.com>
References: <1402769508-3821-1-git-send-email-xerofoify@gmail.com>
 <20140615203058.GA22265@lukather>
 <CAPDOMVj0JSp-ZfvAXkeTqHscKkhmp0ZttN5NVM+BYE_X+jWCcQ@mail.gmail.com>
Message-ID: <CAPDOMVimRry7XejNt9gdqLX4C64T7qsOwEBGvpYLDvxa2H5xuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems the bug is fixed , don't worry about resent patch.
Thanks Nick

On Sun, Jun 15, 2014 at 11:21 PM, Nick Krause <xerofoify@gmail.com> wrote:
> New Patch Just Fixed Typo for my email client.
> Signed-off-by: Nick <xerofoify@gmail.com>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.
> c b/drivers/clk/sunxi/clk-sunxi.c
> index 4264834..6f4fc51 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct
> device_node *node)
>         u32 rate;
>
>         if (of_property_read_u32(node, "clock-frequency", &rate))
> +               kfree(gate);
>                 return;
>
>         /* allocate fixed-rate and gate clock structs */
> Cheers Nick
>
> On Sun, Jun 15, 2014 at 4:30 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Sat, Jun 14, 2014 at 02:11:48PM -0400, Nick wrote:
>>> Signed-off-by: Nick <xerofoify@gmail.com>
>>
>> This should be your full real name here.
>>
>>> ---
>>>  drivers/clk/sunxi/clk-sunxi.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>>> index 4264834..6f4fc51 100644
>>> --- a/drivers/clk/sunxi/clk-sunxi.c
>>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>>> @@ -42,6 +42,7 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
>>>       u32 rate;
>>>
>>>       if (of_property_read_u32(node, "clock-frequency", &rate))
>>> +             kree(gate);
>>
>> There's a typo in kfree. How does that even compile?
>>
>> --
>> Maxime Ripard, Free Electrons
>> Embedded Linux, Kernel and Android engineering
>> http://free-electrons.com
