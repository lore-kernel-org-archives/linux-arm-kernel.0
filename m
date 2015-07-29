From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jul 2015 21:51:15 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 21:27, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>
>> -----Original Message-----
>> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
>> Sent: Thursday, July 23, 2015 7:44 AM
>> To: Yoder Stuart-B08248; Catalin Marinas; Will Deacon
>> Cc: linux-arm-kernel at lists.infradead.org; Newton Peter-RA3823
>> Subject: Re: [RFC] arm64: defconfig: enable 48-bit VA by default
>>
>> On 22/07/15 20:49, Stuart Yoder wrote:
>> > Catalin/Will,
>> >
>> > This is not a patch mean to be applied, but a query about whether there
>> > is any reason to not enable 48-bit VA by default in the arm64 defconfig.
>> >
>> > The Freescale LS2085A physical memory map requires 48-bit VA in Linux for the
>> > reasons mentioned in [1].
>> >
>> > Based on the comment in [1] by Catalin, it seems that the intent
>> > is to turn this on by default.
>> >
>> > Is there any issues anyone sees with a patch that does this:
>> >
>> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> > index 4e17e7e..5acf75d 100644
>> > @@ -47,6 +47,7 @@ CONFIG_ARCH_ZYNQMP=y
>> >  CONFIG_PCI=y
>> >  CONFIG_PCI_MSI=y
>> >  CONFIG_PCI_XGENE=y
>> > +CONFIG_ARM64_VA_BITS_48=y
>> >  CONFIG_SMP=y
>> >  CONFIG_PREEMPT=y
>> >  CONFIG_KSM=y
>> >
>> > Thanks,
>> > Stuart
>> >
>> > [1] https://www.marc.info/?l=linux-arm-kernel&m=140965303205473&w=1
>> >
>>
>> Is that still a requirement now that our idmap can use 4 levels (as part
>> of dd006da)?
>
> So, yes it appears still to be a requirement.  The idmap support is not
> the issue, it's the linear mapping.
>
> Has there been discussion or thinking about enabling 48-bit VA in the
> default defconfig?  As mentioned before, it seemed that supporting 48-bit
> VA was the planned default (~1 year ago), and was waiting on KVM issues to get
> resolved.
>
> A related question is what the thinking around enabling 64KB pages
> by default.  Any chance of that happening?
>
> I would like to see our platform work with the default defconfig, which
> is the reason for the questions.
>

Perhaps you should mention, for the benefit of those not following the
other thread, that the platform in question has 2 chunks of memory,
i.e., 2 GB and 14 GB, with a 508 GB hole in between.

To be honest, I think this is poorly designed, and I am not sure we
should cater for such configurations in the defconfig.

Regards,
Ard.
