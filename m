From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 May 2017 17:11:27 +0200
Subject: [PATCH] arm64: dts: rockchip: fix include reference
In-Reply-To: <1543991.PRPgxyxrAr@phil>
References: <20170519121434.1118129-1-arnd@arndb.de> <1543991.PRPgxyxrAr@phil>
Message-ID: <CAK8P3a2srVLYxuUTAwLu91hzz=GERfgZTVHe7hhXaXrWBWw8KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 2:47 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Arnd,
>
> Am Freitag, 19. Mai 2017, 14:14:34 CEST schrieb Arnd Bergmann:
>> The way we handle include paths for DT has changed a bit, which
>> broke a file that had an unconventional way to reference a common
>> header file:
>>
>> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:10: fatal error: include/dt-bindings/input/linux-event-codes.h: No such file or directory
>>
>> This removes the leading "include/" from the path name, which fixes it.
>>
>> Fixes: d5d332d3f7e8 ("devicetree: Move include prefixes from arch to separate directory")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This mimics the patch from Ian Campbell [0], which I also pointed at in
> the "devicetree: Move include prefixes from arch to separate directory"
> thread and I had originally hoped that both would get applied together.
>
> In any case, both patches look good, so this as well gets a
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> The other one also got a
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
> It seems I don't have any other fixes for 4.12 at the moment, so
> do you want to apply any of the two yourself, or should this make
> a round through my tree? (Both ways are fine by me)
>
>
> Heiko
>
> [0] https://patchwork.kernel.org/patch/9724957/

Ok, thanks!

I already applied my version to the fixes branch as I saw that we have
the build regression after Olof applied his patch.

      Arnd
