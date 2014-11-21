From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 21 Nov 2014 23:05:28 +0530
Subject: [PATCH 7/9] dt: mb86s7x: add dt files for MB86S7x evbs
In-Reply-To: <6351620.x1OFSWlVbH@wuerfel>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <2581182.ZW92kSfUJp@wuerfel>
 <CAJe_ZhfJBftYd7oYNqUsgZsVZS8ccRA5XngJ=msRnt7RSE+C2Q@mail.gmail.com>
 <6351620.x1OFSWlVbH@wuerfel>
Message-ID: <CAJe_Zhee6XG5=izSccDDmL4cTyXLeYO3EdaUA=inmrV5MdF12Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2014 22:39, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 21 November 2014 22:19:43 Jassi Brar wrote:
>> >
>> > This seems weird: rather than have one clock controller node per
>> > clock source, why not just have one node with #clock-cells = >?
>> >
>> > Your controller seems perfectly capable of this, and you even
>> > put the numbers in the label. It would be much more straightforward
>> > to do
>> >
>> >         clocks = <&clk_alw 0 1>;
>> >
>> > than
>> >
>> >         clocks = <&clk_alw_0_1>;
>> >
>> > here. Possibly even
>> >
>> >         clocks = <&clk MB86S70_CRG11_ALW 0 1>;
>> >
>> > with #clock-cells = >
>> >
>> Is there a way to compact the dtsi and yet populate only clocks that
>> are actually ever used (instead of 6x16x9)?
>
> I believe the clock driver just wouldn't create the clocks until
> a device driver requests them.
>
Seems like the chicken-egg problem. Let me check.

Thanks
Jassi
