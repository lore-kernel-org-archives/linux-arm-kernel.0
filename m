From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 3 Apr 2014 15:16:31 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC DT Updates for
 v3.15
In-Reply-To: <20140317074611.GH21917@quad.lixom.net>
References: <cover.1394080829.git.horms+renesas@verge.net.au>
 <20140317074611.GH21917@quad.lixom.net>
Message-ID: <CANqRtoSg8g2vODYaxx7U4BzQxb9piM4Cf_2uBk8O874eopJZsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 4:46 PM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Mar 06, 2014 at 01:44:28PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Kevin, Hi Arnd,
>>
>> Please consider this fourth round of Renesas ARM based SoC DT updates for v3.15.
>>
>> This pull request is based on the previous round of
>> such requests, tagged as renesas-dt3-for-v3.15,
>> which I have already sent a pull-request for.
>>
>>
>> The following changes since commit 367aaaea1d6c6496695ffd06b49590b8cfcb8aa5:
>>
>>   ARM: shmobile: genmai: adapt dts to use native i2c driver (2014-02-18 11:35:30 +0900)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt4-for-v3.15
>
> Hi,
>
> I've merged this into next/dt. However, a general comment on these patches:
>
>> Sergei Shtylyov (4):
>>       ARM: shmobile: r8a7790: add Ether DT support
>>       ARM: shmobile: lager: add Ether DT support
>>       ARM: shmobile: r8a7791: add Ether DT support
>>       ARM: shmobile: koelsch: add Ether DT support
>
> I think you should consider doing a generic binding for the ethernet
> controller, that specifies the data that the driver needs as part of the device
> tree contents. that way you don't have to add a new _data structure for every
> new SoC that implements things -- from taking a brief look at the driver there
> seems to be a bit of boiler plate and/or several parts that share common
> feature sets already.
>
> Anyway, given the way the binding is written, this can be done later by adding
> a generic compatible string that expects more properties, etc -- so it's not
> something that needs to be done now. But I do recommend that as you add new
> SoCs in the future (if you do).

Hi Olof,

Thanks for your suggestion. If I understand your proposal correctly
then you recommend us to make the driver more generic and
configuration driven based on configuration from DT. In general I
agree about this direction, but in the case of sh-eth this seems
difficult due to huge differences between different IP variants. And
to make it worse, the documentation is often of poor quality with no
real IP version information. Because of this we keep knowledge in the
driver and adjust behavior using the SoC number as suffix in the
compatible string. The SoC number is the only "stable id" we have that
is suitable for DT ABI unfortunately.

Of course I welcome further data sharing, cleanups and bug fixes for
this driver. If you can think of anything in particular please let me
or one of the sh-eth developers know. I will do my best to help you.

Thanks,

/ magnus
