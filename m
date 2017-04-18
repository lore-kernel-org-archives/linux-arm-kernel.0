From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 17:22:02 +0800
Subject: [PATCH 2/3] ARM: sun8i: a83t: Drop leading zeroes from device
 node addresses
In-Reply-To: <20170418090329.odixwybrkqvp2o7z@lukather>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-3-wens@csie.org>
 <20170418090329.odixwybrkqvp2o7z@lukather>
Message-ID: <CAGb2v664r+Wt9zrSK2GudMYRkp9N+QpdbEMdWEobx-HxS38Ovw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 5:03 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Apr 18, 2017 at 12:22:04PM +0800, Chen-Yu Tsai wrote:
>> Kbuild now complains about leading zeroes in the address portion of
>> device node names.
>>
>> Get rid of them.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun8i-a83t.dtsi | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> index 913aacafe8d5..82cb87f21b96 100644
>> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
>> @@ -162,7 +162,7 @@
>>               #size-cells = <1>;
>>               ranges;
>>
>> -             pio: pinctrl at 01c20800 {
>> +             pio: pinctrl at 1c20800 {
>
> As far as I know this breaks Uboot's auto-addition of stdout-path

You're right. It breaks as Uboot has the path to the uarts hard-coded.
That sucks. And from what I can tell, it's not easily solvable by just
switching to serial alias based references. CONS_INDEX won't line up
on the A23/A33 Q8 tablets.

Maybe we can just keep the uart device node the same for now, but fix
all the other ones. We can come back and fix the uart later once we
figure out how to fix Uboot.

Regards
ChenYu
