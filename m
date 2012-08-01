From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 01 Aug 2012 13:35:17 -0700
Subject: [RFC] ARM: imx6q-sabrelite: Add CLKO IOMUX
In-Reply-To: <CAOMZO5A2g+UCFuiP7yqYkFQ36F=2yrqJA3ssujeYXE_Q0Sz5nQ@mail.gmail.com>
References: <1343833836-14287-1-git-send-email-festevam@gmail.com>
 <CAOMZO5A2g+UCFuiP7yqYkFQ36F=2yrqJA3ssujeYXE_Q0Sz5nQ@mail.gmail.com>
Message-ID: <50199305.60802@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2012 1:17 PM, Fabio Estevam wrote:
> On Wed, Aug 1, 2012 at 12:10 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> In order to have audio functional on mx6qsabrelite, it is necessary to setup
>> the IOMUX for MX6Q_PAD_GPIO_0__CCM_CLKO and MX6Q_PAD_GPIO_3__CCM_CLKO2 pins.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> Dirk,
>>
>> Not tested. If you have a chance to try it, please let me know.
> I managed to get a board and tried it with current Linus' tree and
> also linux-next. Both result in:
>
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: asoc: failed to probe CODEC sgtl5000.0-000a: -19
> asoc: failed to instantiate card imx6q-sabrelite-sgtl5000: -19
> imx-sgtl5000 sound.11: snd_soc_register_card failed (-19)
>
> Any ideas?
>
> Thanks,
>
> Fabio Estevam
>
No idea, but a comment.

GPIO_0 is needed for SGTL500 - sys_mclk
GPIO_3 is needed for Camera mclk, no audio dependency.

Troy
