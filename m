From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 12:26:11 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: add GPIO nodes for the BG2Q
In-Reply-To: <20140415180058.2fefca78@xhacker>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-3-git-send-email-antoine.tenart@free-electrons.com>
 <534CFA77.9030108@gmail.com> <20140415180058.2fefca78@xhacker>
Message-ID: <534D0943.2050100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 12:00 PM, Jisheng Zhang wrote:
> On Tue, 15 Apr 2014 02:23:03 -0700
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> On 04/15/2014 10:07 AM, Antoine T?nart wrote:
>>> The Marvell Berlin BG2Q has 6 GPIO ports compatible with the
>>> snps,dw-apb-gpio driver. This patch add the corresponding device tree
>>> nodes.
>>>
>>> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>>> ---
>>>    arch/arm/boot/dts/berlin2q.dtsi | 102
>>> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 102 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
>>> b/arch/arm/boot/dts/berlin2q.dtsi index e6e556055dfc..b2625f896bc5 100644
>>> --- a/arch/arm/boot/dts/berlin2q.dtsi
>>> +++ b/arch/arm/boot/dts/berlin2q.dtsi
[...]
>>> +					compatible =
>>> "snps,dw-apb-gpio-port";
>>> +					gpio-controller;
>>> +					#gpio-cells = <2>;
>>> +					snps,nr-gpios = <32>;
>>
>> 32 gpio pins for each of the 6 GPIO controllers? Either BG2Q is a GPIO
>
> Yes, BG2Q support 32 pins every port

Wow. Thanks for confirming this!

>> I am fine with using nr-gpios property now, but I guess BG2Q also
>> has that CONFIG[1,2] registers to actually read out the features
>> synthesized in? If I find some time, I'll prepare a patch for
>> dw-apb-gpio to exploit that (optional) information instead of
>> using nr-gpios.
>
> The problem is CONFIG1/2 registers don't exist on some versions.
> For example, the version used in BG2/BG2CD. So nr-gpio is necessary
> if we want to support these versions.

Hmm, are you sure about BG2? I remember reading it and it contains
sane values. Anyway, a proper patch for dw-apb-gpio would include
checking for sane (e.g. non-zero) values. And nr-gpios will always
stay as fall-back just because e.g. sunxi does not have the CONFIG
registers.

Sebastian
