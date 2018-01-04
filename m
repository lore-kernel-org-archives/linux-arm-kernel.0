From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 00:01:03 +0100
Subject: [PATCH V7 12/12] arm64: dts: add clocks for SC9860
In-Reply-To: <CAK8P3a3XA+p__p9+B-jCONUDe1MuOgsee6oD0USmwK06iXqH9g@mail.gmail.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
 <20171207125715.16160-13-chunyan.zhang@spreadtrum.com>
 <CAK8P3a3XA+p__p9+B-jCONUDe1MuOgsee6oD0USmwK06iXqH9g@mail.gmail.com>
Message-ID: <CAK8P3a2Qpbr6EB+qWMQqCLkbnVddL+MHx1sFNs-+97ZQ=QaHeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 10:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Dec 7, 2017 at 1:57 PM, Chunyan Zhang
> <chunyan.zhang@spreadtrum.com> wrote:
>> Some clocks on SC9860 are in the same address area with syscon devices,
>> those are what have a property of 'sprd,syscon' which would refer to
>> syscon devices, others would have a reg property indicated their address
>> ranges.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  arch/arm64/boot/dts/sprd/sc9860.dtsi | 115 +++++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/sprd/whale2.dtsi |  18 +++++-
>>  2 files changed, 131 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> index 7b7d8ce..bf03da4 100644
>> --- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> +++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
>> @@ -7,6 +7,7 @@
>>   */
>>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/sprd,sc9860-clk.h>
>>  #include "whale2.dtsi"
>
> This caused a build error since the sprd,sc9860-clk.h file does not
> exist, I'll revert or undo the patch tomorrow.

I've taken another look, and fixing it by removing the broken #include
was easier than undoing the patches, so I did that now, see
https://patchwork.kernel.org/patch/10145773/

      Arnd
