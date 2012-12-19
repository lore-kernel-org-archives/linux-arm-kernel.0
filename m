From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 19 Dec 2012 19:50:59 +0900
Subject: [PATCH 1/2] ARM: r8a7740: Add interim sh-eth device name to
 clocks list
In-Reply-To: <Pine.LNX.4.64.1212191005280.12389@axis700.grange>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
 <Pine.LNX.4.64.1212191005280.12389@axis700.grange>
Message-ID: <CANqRtoQZa35XGL2qQ1SONJ+3JBXMesjHL_tJV_9b96V2K3+xZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 6:10 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Bastian
>
> Thanks for the patch.
>
> On Tue, 18 Dec 2012, Bastian Hecht wrote:
>
>> When we use the ethernet device via DT setup, we need to add it
>> to a lookup list until this is properly handled later in a DT-only
>> fashion.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
>> index 19ce885..8765a76 100644
>> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
>> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
>> @@ -614,6 +614,7 @@ static struct clk_lookup lookups[] = {
>>       CLKDEV_DEV_ID("sh_mobile_sdhi.1",       &mstp_clks[MSTP313]),
>>       CLKDEV_DEV_ID("sh_mmcif",               &mstp_clks[MSTP312]),
>>       CLKDEV_DEV_ID("sh-eth",                 &mstp_clks[MSTP309]),
>> +     CLKDEV_DEV_ID("e9a00000.sh-eth",        &mstp_clks[MSTP309]),
>
> In a recent thread
>
> http://thread.gmane.org/gmane.linux.ports.sh.devel/18062/focus=18057
>
> I've been suggested to use OF_DEV_AUXDATA(), isn't this also a case for
> it?

AUXDATA seems to be a great way to add a platform data pointer as a
workaround while implementing DT support, but when it comes to
translate the name based on base address the code becomes very
verbose.

I am all for going with the simplest half-way solution that uses the
least amount of lines of code, but I doubt it can get any simpler than
a single line of CLKDEV_DEV_ID().

Thanks,

/ magnus
