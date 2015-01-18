From: jcm@redhat.com (Jon Masters)
Date: Sun, 18 Jan 2015 07:32:23 -0500
Subject: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <20150118092955.GE6182@xora-haswell.xora.org.uk>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <54BB56CB.7040701@linaro.org>
 <20150118092955.GE6182@xora-haswell.xora.org.uk>
Message-ID: <54BBA7D7.2000804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2015 04:29 AM, Graeme Gregory wrote:
> On Sun, Jan 18, 2015 at 02:46:35PM +0800, Hanjun Guo wrote:
>> On 2015?01?18? 14:31, Jon Masters wrote:
>>> Hi Folks,
>>>
>>> Sorry for top posting from bed. The mainstream servers will all likely do
>>> PCIe but there are several that may not. They should not be excluded. That
>> said,
>>> if we booted a previously built kernel on a system without an MCFG and
>>> got no ECAM/root then things would probably still work.
>>>
>>> I think it'll work out either way but for the record there is no requirement to do PCIe on ARM servers that conform to spec.
>>
>> OK, Catalin already said that was not the main point of the
>> comments for this patch, I think the title and change log
>> of the patch is inconsistent with the code makes Catalin confused,
>> I will update them in next version.
>>
> Well what we are talking about is the presence of CONFIG_PCI=y which even
> in Jons case will be true as he wants to run the same kernel on both
> sets of hardware.

Yup. And btw, the ACPI+PCI use case works beautifully already today. I
will followup to my other Tested-by with a bit more detail later, but
these patches have successfully been used on a wide range of PCIe based
hardware already (I personally have tried a number of 10G network cards,
SATA, USB, and even a graphics card or two for giggles).

Jon.
