From: fkan@apm.com (Feng Kan)
Date: Fri, 6 Jan 2017 15:21:34 -0800
Subject: APM smmu implementation
Message-ID: <CAL85gmA_SSCwM80TKdkZqEe+S1beWzDEvdki1kpkmUTDRmSP7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Robin:

The APM IOMMU implementation is mostly just the ARM SMMU 500 variant.
However, our internal bus is only 42 bits wide. Our IAS field is coded
as 48 bits, which cause IPA to truncated to 42 bits on the physical
bus. In order for our system to work with the arm-smmu.c, there needs
to be a way to force the ipa_size to 42. The current internal solution
is to use the cpuid, but that is quite ugly. I was thinking of using
the model
as indication to right the ipa_size, but I am not too sure of the ACPI
side. Would it be okay to add an APM MMU500 variant? I would also
appreciated it if you guys have any alternate solutions.

Thanks
Feng Kan
