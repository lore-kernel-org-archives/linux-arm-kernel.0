From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 30 Sep 2015 08:44:35 +0200
Subject: [PATCH 30/31] ARM: shmobile: r8a7791: add USB-DMAC device nodes
In-Reply-To: <560B11FF.3010305@cogentembedded.com>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
 <e3e25edc1116ebf44b1813aff03b02b7737d41ca.1431565427.git.horms+renesas@verge.net.au>
 <560B11FF.3010305@cogentembedded.com>
Message-ID: <CAMuHMdWuAz1gGbFzgjn7mM+Q6fgqjSCG-+8VtZ+4AMJG72mbtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Sep 30, 2015 at 12:34 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/14/2015 04:06 AM, Simon Horman wrote:
>
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>>   arch/arm/boot/dts/r8a7791.dtsi | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>
>
>    When the USB-DMAC driver is enabled, this causes kernel oops on at least
> the R8A7791 Henninger/Porter boards (haven't checked the others yet) with
> renesas-devel-20150928-v4.3-rc3 and even earlier tag. The oops can only be
> seen with the earlyprintk=serial kernel parameter, otherwise the kernel just
> hangs with a blank console.

My current kernel on r8a7791/koelsch has CONFIG_RENESAS_USB_DMAC=y and boots
fine.

renesas-devel-20150928-v4.3-rc3 with shmobile_defconfig +
CONFIG_RENESAS_USB_DMAC=y also boots fine.

Do I need to enable/disable config options to trigger this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
