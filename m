From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 11 Mar 2013 12:33:18 +0100
Subject: [PATCH v2 5/7] ARM: mach-shmobile: sh73a0: Setup the timer CMT10
 using DT
In-Reply-To: <87y5duhjru.wl%kuninori.morimoto.gx@renesas.com>
References: <1362742181-19111-1-git-send-email-hechtb+renesas@gmail.com>
 <1362742181-19111-6-git-send-email-hechtb+renesas@gmail.com>
 <87y5duhjru.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CABYn4sy=9Wkh7tCsBpna4hwX3ptRwCeC_+ys0apAHGbjjieN2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Morimoto-san!

2013/3/11 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Bastian
>
> 1 question
>
>> We can now use the Device Tree for bringing up our timer device CMT10 on
>> the SoC sh73a0.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> (snip)
>>  /* TMU */
>>  static struct sh_timer_config tmu00_platform_data = {
>>       .name = "TMU00",
>> @@ -913,7 +882,6 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
>>       &scif6_device,
>>       &scif7_device,
>>       &scif8_device,
>> -     &cmt10_device,
>>  };
>
> I didn't test this patch,
> but setup-sh73a0.c :: sh73a0_devices_dt is
> used from sh73a0_add_standard_devices() or sh73a0_add_early_devices(),
> and it is used from board-kzm9g.c (not -reference.c).
>
> Does board-kzm9g.c still works ?
> Is it better that sh73a0_early_devices[] has it ?
>

As the timer devices have no board dependencies we can put them into
the general sh73a0.dtsi and it works for the reference and
no-reference case.

Still - while rechecking it I discovered a small slip I made in my
series. In 0003-Add OF to TMU I forgot 2 trivial lines. So thanks for
asking ;)

Cheers,

 Bastian


> Best regards
> ---
> Kuninori Morimoto
