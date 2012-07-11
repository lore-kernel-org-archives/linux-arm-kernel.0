From: otavio@ossystems.com.br (Otavio Salvador)
Date: Wed, 11 Jul 2012 12:54:11 -0300
Subject: [PATCH v6 3/7] ARM: imx6q: disable usb charger detector
In-Reply-To: <20120711140201.GA2774@richard-laptop>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-4-git-send-email-richard.zhao@freescale.com>
 <CAP9ODKpGiW43E4Cq8MDb-83G7B3Y57AVGz9oaBVzmW83SykUYg@mail.gmail.com>
 <20120711140201.GA2774@richard-laptop>
Message-ID: <CAP9ODKpuV38dBbH=Z1QBCL2P0YEQkjOAH9-NuEQa0PSrak_=Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 11:02 AM, Richard Zhao <linuxzsc@gmail.com> wrote:
> On Wed, Jul 11, 2012 at 10:28:07AM -0300, Otavio Salvador wrote:
>> On Wed, Jul 11, 2012 at 8:33 AM, Richard Zhao
>> <richard.zhao@freescale.com> wrote:
>> > The external charger detector needs to be disabled,
>> > or the signal at DP will be poor
>>
>> Something as this needs to be applied, no?
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index eff4db5..93695e0 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -832,6 +832,9 @@ config SOC_IMX6Q
>>         select HAVE_SMP
>>         select PINCTRL
>>         select PINCTRL_IMX6Q
>> +       select MFD_ANATOP
> This is needed.
>> +       select REGULATOR
>> +       select REGULATOR_ANATOP
> but why these two?

I did it some time ago and ended up adding it ... don't recall why but
MFD only does fix the build failure ... I sent a patch with that.

-- 
Otavio Salvador                             O.S. Systems
E-mail: otavio at ossystems.com.br  http://www.ossystems.com.br
Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br
