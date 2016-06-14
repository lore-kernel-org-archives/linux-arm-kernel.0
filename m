From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 14 Jun 2016 16:01:52 +0200
Subject: [PATCH 05/13] ARM: shmobile: genmai dts: Update console parameters
In-Reply-To: <20151210070434.GB17682@verge.net.au>
References: <1449597258-32623-1-git-send-email-geert+renesas@glider.be>
 <1449597258-32623-6-git-send-email-geert+renesas@glider.be>
 <20151210070434.GB17682@verge.net.au>
Message-ID: <CAMuHMdU9p8-7BXwT8EwTQDZ1fFt=O0jRV5fqU3V987uaVUtVgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 8:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Dec 08, 2015 at 06:54:10PM +0100, Geert Uytterhoeven wrote:
>> Change the console alias to "serial0", for consistency with other
>> boards (the first unlabeled serial port is always called "serial0").
>> Add serial port config to chosen/stdout-path.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/boot/dts/r7s72100-genmai.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
>> index a9da7a89fc4ba65a..47533c2c419e164d 100644
>> --- a/arch/arm/boot/dts/r7s72100-genmai.dts
>> +++ b/arch/arm/boot/dts/r7s72100-genmai.dts
>> @@ -17,12 +17,12 @@
>>       compatible = "renesas,genmai", "renesas,r7s72100";
>>
>>       aliases {
>> -             serial2 = &scif2;
>> +             serial0 = &scif2;
>>       };
>>
>>       chosen {
>>               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>> -             stdout-path = &scif2;
>> +             stdout-path = "serial0:115200n8";
>>       };
>>
>>       memory {
>
> As noted elsewhere the serial2 -> serial0 portion of
> this patch seems to result in no console.
>
> I am wary about that change as it is user-space visible
> but I didn't expect it to also have an impact on the kernel console.
>
> In case it helps anyone now or in the future the output with earlyprintk
> follows.
>
> -- after with early printk --

> [    0.000000] Kernel command line: console=ttySC2,115200 root=/dev/nfs rw ip=dhcp ignore_loglevel earlyprintk=sh-sci.2,115200

Got you! Stale "bootargs" environment variable overriding the console.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
