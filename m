From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 18 Dec 2013 23:44:30 +0900
Subject: [PATCH 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <52B1AAE6.2020400@cogentembedded.com>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-3-git-send-email-wsa@the-dreams.de>
 <52B1892B.1020806@cogentembedded.com>
 <20131218114351.GD3314@katana>
 <52B18CC9.8090200@cogentembedded.com>
 <20131218121541.GE3314@katana>
 <20131218134914.GA32664@verge.net.au>
 <52B1AAE6.2020400@cogentembedded.com>
Message-ID: <CANqRtoQ953DA-=DFXvkuLMJ6SBvobQdg5LByScPb+x84TJKkCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:02 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 18-12-2013 17:49, Simon Horman wrote:
>
>>>>>>> @@ -173,6 +179,10 @@ static struct clk_lookup lookups[] = {
>>>>>>>         CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
>
>
>>>>>>>         /* ICK */
>>>>>>> +       CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>>>>>> +       CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>>>>>> +       CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>>>>>> +       CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>
>
>>>>>>     These belong to some other place, the group marked by /* ICK */
>>>>>> is only for CLKDEV_ICK_ID().
>
>
>>>>> So, I'll create a /* DEV */ prefix?
>
>
>>>>     I really don't know. Other places have /* MSTP */ comment in this
>>>> case despite all clocks, CLKDEV_DEV_ID() and CLKDEV_ICK_ID() are
>>>> really MSTP clocks. I considered the idea of separating
>>>> CLKDEV_ICK_ID() under /* ICK */ comment silly from the very start
>>>> but Simon didn't listen to me.
>
>
>>> I am puzzled, too. ICK is a type of registration and not a clock domain.
>>> Also, there is 'mtu2_fck' which is under ICK as well as MSTP? Looks
>>> wrong. From what I understand now, removing the /* ICK */ comment would
>>> be easiest and proper?
>
>
>> I'm not sure that I really understand what all the fuss is about.
>
>
>> As I understand things the convention that prevails for
>> MSTP clocks under mach-shmobile is as follows:
>
>
>> 1. Clocks not registered by CLKDEV_ICK_ID() are grouped together
>>     under /* MSTP */ followed by:
>> 2. Clocks registered using CLKDEV_ICK_ID() are grouped together
>>     under /* ICK */
>
>
>> I am unsure of the historical reason for this
>
>
>    Recent patches by Morimoto-san.
>
>
>> but it does seem to be consistent.
>
>
>    No, it doesn't. These comments are *clearly* not consistent and should be
> removed at least.

Feel free to contribute patches!

/ magnus
