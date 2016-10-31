From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Oct 2016 07:24:45 -0700
Subject: [PATCH 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
In-Reply-To: <fce063fd-6aaa-8d30-1588-e656e93bdebc@baylibre.com>
References: <20161021151037.20112-1-narmstrong@baylibre.com>
 <fce063fd-6aaa-8d30-1588-e656e93bdebc@baylibre.com>
Message-ID: <CAOesGMjsjYPKyH2CD4siZmB3F64h+c7vndfjFdniTDLB4Eh4Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 31, 2016 at 2:58 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 10/21/2016 05:10 PM, Neil Armstrong wrote:
>> This patchset updates the ARM DTS for the Oxnas platform by :
>> - Add support for the Oxford Semicondutor OX820 and the PogoPlug V3
>> - Update the OX810SE to use the dt-bindings includes files introduced in [1] and [2]
>> - Fix the MAINTAINERS entry and add the PogoPlug V3 file maintainance
>>
>> This patchset depends on dt-bindings include headers posted at [1] and [2],
>> that were accepted/merged in the subsystem trees.
>>
>> How could I manage this dependency for 4.10 ?
>>
>> [1] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00008.html
>> [2] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00007.html
>>
>> Neil Armstrong (3):
>>   ARM: dts: Add support for OX820 and Pogoplug V3
>>   ARM: dts: OX810: Update with dt-bindings includes
>>   MAINTAINERS: oxnas: Add new files definitions
>>
>>  Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
>>  MAINTAINERS                                        |   3 +-
>>  arch/arm/boot/dts/Makefile                         |   3 +-
>>  .../boot/dts/cloudengines-pogoplug-series-3.dts    |  94 +++++++
>>  arch/arm/boot/dts/ox810se.dtsi                     |  10 +-
>>  arch/arm/boot/dts/ox820.dtsi                       | 298 +++++++++++++++++++++
>>  6 files changed, 407 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
>>  create mode 100644 arch/arm/boot/dts/ox820.dtsi
>>
>
> Hi,
>
> I'm ready to send a pull request for arm-soc-dt, but I need to understand how this dependency
> should be worked out.
>
> Should this be sent as a late pull request ?


The need for dt-include changes is one of my pet peeves these days,
since they require coordination between trees.

There's two ways to solve this:

1) Make sure that the branches you sent to other maintainers are
stable, that they merge them as-is and don't rebase. This is a
three-way handshake (we want to be cc:d on it). Then base your branch
on top of those two branches.

or:

2) Avoid using the includes now, using numerical constants instead.
Then, after next merge window, follow up with a patch that converts to
symbols.


-Olof
