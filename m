From: fkan@apm.com (Feng Kan)
Date: Mon, 9 Jan 2017 09:37:55 -0800
Subject: APM smmu implementation
In-Reply-To: <20170109105421.GA21398@arm.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
 <20170109105421.GA21398@arm.com>
Message-ID: <CAL85gmA-14azx0RUX7jNNZbWDtkumGyYYBYEM6yHXUfSui1GAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 9, 2017 at 2:54 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jan 06, 2017 at 03:21:34PM -0800, Feng Kan wrote:
>> The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.
>> However, our internal bus is only 42 bits wide. Our IAS field is coded
>> as 48 bits, which cause IPA to truncated to 42 bits on the physical
>> bus. In order for our system to work with the arm-smmu.c, there needs
>> to be a way to force the ipa_size to 42. The current internal solution
>> is to use the cpuid, but that is quite ugly. I was thinking of using
>> the model
>
> Just so I understand, what are the UBS and OAS values on your part?

UBS/OAS/IAS are all default to 5.
>
>> as indication to right the ipa_size, but I am not too sure of the ACPI
>> side. Would it be okay to add an APM MMU500 variant? I would also
>> appreciated it if you guys have any alternate solutions.
>
> For this sort of implementation erratum, I think using the model field
> is the right thing to do. However, you'll need to get your model registered
> with IORT, so I've added Charles to cc since he maintains that document.
>
> Also, please add a device-tree property to override the IAS once you
> start writing patches.
>
> Will
