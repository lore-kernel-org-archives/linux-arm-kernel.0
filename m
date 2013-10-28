From: robherring2@gmail.com (Rob Herring)
Date: Mon, 28 Oct 2013 14:57:04 -0500
Subject: [PATCH 4/8] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <526E065F.60206@uclinux.org>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-5-git-send-email-gerg@uclinux.org>
 <CAL_JsqJhM=K+vovDALQnjUSXBcuzHev1CUpxEnNqCYfOfGVsWQ@mail.gmail.com>
 <526E065F.60206@uclinux.org>
Message-ID: <CAL_JsqJbWXvE9kCwAQqkvd5MzQeo5oEBKjYFx1a1XWx1k3GNUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 1:38 AM, Greg Ungerer <gerg@uclinux.org> wrote:
> Hi Rob,
>
> On 24/10/13 21:11, Rob Herring wrote:
>> On Fri, Oct 18, 2013 at 1:04 AM,  <gerg@uclinux.org> wrote:
>>> From: Greg Ungerer <gerg@uclinux.org>
>>>
>>> Add machine support code for the Freescale IMX50 SoC.


>>> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
>>> +       .map_io         = mx53_map_io,
>>> +       .init_early     = imx53_init_early,
>>> +       .init_irq       = mx53_init_irq,
>>> +       .handle_irq     = imx53_handle_irq,
>>> +       .init_time      = imx50_timer_init,
>>> +       .init_machine   = imx50_dt_init,
>>> +       .init_late      = imx53_init_late,
>>> +       .dt_compat      = imx50_dt_board_compat,
>>> +       .restart        = mxc_restart,
>>> +MACHINE_END
>>
>> This seems like a lot of duplication. It seems like mx53 and mx50
>> could be combined into a single machine_desc. init_time should not be
>> needed in 3.13.
>
> Are you suggesting that "fsl,imx50" be added to the board compat list
> in mach-imx53.c instead?

Yes, that would be at least part of it. I'd guess a bit more than that
is needed.

Rob
