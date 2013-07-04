From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 3 Jul 2013 22:07:35 -0700
Subject: On common struct clk in clock framework.
In-Reply-To: <CAM2a4uxMO4JjA-_QS_x+9FB38CYJFWCcYQk-kTc7YXMVuJ91Ug@mail.gmail.com>
References: <CAM2a4uyrX0t-W8hXKROvZgJPSyCY+DaviV-eRVZOhyPx=WNBUw@mail.gmail.com>
 <16151917.X00PMOJFZ6@flatron>
 <CAM2a4uxMO4JjA-_QS_x+9FB38CYJFWCcYQk-kTc7YXMVuJ91Ug@mail.gmail.com>
Message-ID: <CAPtuhTgne+GrCwiSpJn5ngV5qaZwQTe82sLSM+3Dvr5nfCE9Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 3, 2013 at 9:51 PM, mind entropy <mindentropy@gmail.com> wrote:
> On Wed, Jul 3, 2013 at 11:37 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>
>> The examples you pointed are not using Common Clock Framework. See
>> Documentation/clk.txt and drivers/clk/ for more information about CCF.
>>
>> As for s3c24xx, CCF driver for the whole platform is already merged for
>> Linux 3.11.
>>
>> Best regards,
>> Tomasz
>>
>
> Thanks TomasZ. I have gone through the docs and was quite confused. I
> will have a look at the merge.

Any clock implementation that defines its own struct clk is a legacy
clock framework and is not using the common clock infrastructure.
Another hint is if you see a clock driver that includes
linux/clk-provider.h, this implies a clock driver that is using the
common clock framework.

Regards,
Mike

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
