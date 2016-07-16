From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 16 Jul 2016 11:09:31 +0800
Subject: [GIT PULL] Allwinner DT patches for 4.8, take 2
In-Reply-To: <4794027.B8xcHDgPAJ@wuerfel>
References: <20160715105243.GA4468@lukather> <4794027.B8xcHDgPAJ@wuerfel>
Message-ID: <CAGb2v65=U8hSN9WLoOaoiRyR2Z8ixJ2Chhcv2MV1DVTkCYyMWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Sat, Jul 16, 2016 at 4:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday, July 15, 2016 12:52:43 PM CEST Maxime Ripard wrote:
>> Hi Arnd, Kevin, Olof,
>>
>> Here is the final (hopefully) pull request for the Allwinner SoCs for
>> the 4.8 merge window.
>>
>> Thanks!
>> Maxime
>>
>> The following changes since commit d509e205d81f074a9b8d93ac80ab56405dede48b:
>>
>>   ARM: dts: sun5i: Enable otg on the auxtex t004 (2016-07-05 08:54:33 +0200)
>>
>> are available in the git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.8-2
>>
>> for you to fetch changes up to 339120c5f638727a8359b054ec06ed2d66dc9b19:
>>
>>   ARM: dts: sun8i: Add dts file for inet86dz board (2016-07-11 08:39:27 +0200)
>>
>> ----------------------------------------------------------------
>> Allwinner DT changes for 4.8, take 2
>>
>> Another set of changes for the 4.8 merge window, among which:
>>   - Reworking of the DT for the tablets based on Allwinner reference design
>>     and q8 designs to avoid duplication as much as possible
>>   - Renaming a DT merged in the first PR for consistency
>>   - Enable a few devices on some boards
>>   - New boards: Polaroid MID2407PXE03, inet86dz
>>
>
> This breaks the allmodconfig build, not pulling:
>
>   DTC     arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dtb
> Error: ../arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts:252.1-18 Label or path usb_power_supply not found

Commit 7409d9ba72ef ("ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG"
depends on the regulator/OPP patch that you wanted me to rework.

Please drop this patch for now.

ChenYu

> Please send a fixed pull request.
>
>         Arnd
