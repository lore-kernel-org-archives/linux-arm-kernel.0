From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Dec 2011 09:06:41 -0800
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
In-Reply-To: <20111220082641.GQ14542@n2100.arm.linux.org.uk>
References: <1324353802-31774-1-git-send-email-olof@lixom.net>
 <20111220082641.GQ14542@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMjh2DmzgjvoYZyDygADDcMwf-m7E3Np0f=h8xRWZZ6-4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 12:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 19, 2011 at 08:03:22PM -0800, Olof Johansson wrote:
>> Silence a bunch of section warnings, and mark some of the init functions as
>> __init.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>> ?arch/arm/mach-tegra/board-harmony-pinmux.c ? | ? ?8 ++++----
>> ?arch/arm/mach-tegra/board-paz00-pinmux.c ? ? | ? ?8 ++++----
>> ?arch/arm/mach-tegra/board-seaboard-pinmux.c ?| ? 16 ++++++++--------
>> ?arch/arm/mach-tegra/board-trimslice-pinmux.c | ? ?4 ++--
>> ?4 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
>> index 465808c..84cfbef 100644
>> --- a/arch/arm/mach-tegra/board-harmony-pinmux.c
>> +++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
>> @@ -25,7 +25,7 @@
>> ?#include "board-harmony.h"
>> ?#include "board-pinmux.h"
>>
>> -static struct tegra_pingroup_config harmony_pinmux[] = {
>> +static __initdata struct tegra_pingroup_config harmony_pinmux[] = {
>
> __initdata goes at the end of the declaration - just before the '='.

Thanks for pointing it out -- looks like a couple of other instances
use the wrong location as well (probably added by me in the past).
I'll respin the patch, and fix up those cases as well.

-Olof
