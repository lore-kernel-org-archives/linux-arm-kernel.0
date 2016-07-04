From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 4 Jul 2016 02:10:04 +0000
Subject: [PATCH 2/7] arm: mach-shmobile: pm-rmobile: add missing
 of_node_put after calling of_parse_phandle
In-Reply-To: <CAMuHMdVE8VzPunLzr7WO-kzcg25rKvFkoQcjJ4czwrQxX_obiw@mail.gmail.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <1467366121-14120-3-git-send-email-peter.chen@nxp.com>
 <CAMuHMdVE8VzPunLzr7WO-kzcg25rKvFkoQcjJ4czwrQxX_obiw@mail.gmail.com>
Message-ID: <HE1PR04MB14504D0A5905A777452DC57D8B380@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>On Fri, Jul 1, 2016 at 11:41 AM, Peter Chen <peter.chen@nxp.com> wrote:
>> of_node_put needs to be called when the device node which is got from
>> of_parse_phandle has finished using.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Signed-off-by: Peter Chen <peter.chen@nxp.com>
>
>NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> --- a/arch/arm/mach-shmobile/pm-rmobile.c
>> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
>> @@ -209,6 +209,7 @@ static void __init add_special_pd(struct device_node *np,
>enum pd_types type)
>>         special_pds[num_special_pds].pd = pd;
>
>The pd pointer is stored in the line above, and released later in put_special_pds().
>
>>         special_pds[num_special_pds].type = type;
>>         num_special_pds++;
>> +       of_node_put(pd);
>
>Hence it must not be released here, as that would cause a double release when
>put_special_pds() is executed.
>

Thanks, Geert, it is my careless.

Please forget this patch.

Peter
