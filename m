From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 16 Sep 2014 09:44:52 +0800
Subject: [PATCH 08/11] ARM: dts: rockchip: add operating points and armclk
 references
In-Reply-To: <CAFnsNoRdW8icUsuEhMq4YB6wi0njoxu3Vvjv6USKTKec_bJwPg@mail.gmail.com>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>	<1409958374-30937-9-git-send-email-heiko@sntech.de>	<CAD=FV=U0h2nDQf6JzErhUn+R7384xSTeTjga03MZtOccf7S0bg@mail.gmail.com>	<5412A1E3.1090707@rock-chips.com>
 <CAFnsNoRdW8icUsuEhMq4YB6wi0njoxu3Vvjv6USKTKec_bJwPg@mail.gmail.com>
Message-ID: <54179614.7040707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naoki FUKAUMI,

On 09/12/2014 07:37 PM, Naoki FUKAUMI wrote:
> Hi Kever Yang,
>
> On Fri, Sep 12, 2014 at 4:33 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
>> Here is the general OPP table for rk3288 we recommend to use in upstream:
>>
>>     operating-points = <
>>                  /* KHz    uV */
>>                  1608000 1350000
>>                  1512000 1300000
>>                  1416000 1200000
>>                  1200000 1100000
>>                  1008000 1050000
>>                  816000 1000000
>>                  696000 950000
>>                  600000 900000
>>                  408000 900000
>>                  312000 900000
>>                  216000 900000
>>                  126000 900000
>>                  >;
>>
>> After this,
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>>
>> Note that the CPU can't not stay on top frequency for a long time, the cpu
>> might overheat, the cpufreq is better to work with cpu thermal for rk3288.
> This commit says 1800000 is safe, but actually it's not safe?
>   https://bitbucket.org/T-Firefly/firefly-rk3288/commits/7048675eec554a1aa4a3874c7bb24806e1e1c06b/raw/
As you have seen, that patch is for a dts file which is board related  
instead of rk3288.dtsi,
it should be safe for T-firefly board, but I'm not sure it works for all 
the boards.

The operation table I provide for rk3288.dtsi with conservative values 
and available for all boards
based on rk3288, and maybe need an OPP table with optimized values in 
dts board file
for board customized.

-Kever
