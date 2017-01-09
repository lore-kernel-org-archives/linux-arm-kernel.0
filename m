From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jan 2017 10:54:21 +0000
Subject: APM smmu implementation
In-Reply-To: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
References: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
Message-ID: <20170109105421.GA21398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 03:21:34PM -0800, Feng Kan wrote:
> The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.
> However, our internal bus is only 42 bits wide. Our IAS field is coded
> as 48 bits, which cause IPA to truncated to 42 bits on the physical
> bus. In order for our system to work with the arm-smmu.c, there needs
> to be a way to force the ipa_size to 42. The current internal solution
> is to use the cpuid, but that is quite ugly. I was thinking of using
> the model

Just so I understand, what are the UBS and OAS values on your part?

> as indication to right the ipa_size, but I am not too sure of the ACPI
> side. Would it be okay to add an APM MMU500 variant? I would also
> appreciated it if you guys have any alternate solutions.

For this sort of implementation erratum, I think using the model field
is the right thing to do. However, you'll need to get your model registered
with IORT, so I've added Charles to cc since he maintains that document.

Also, please add a device-tree property to override the IAS once you
start writing patches.

Will
