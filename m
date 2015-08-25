From: suravee.suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Tue, 25 Aug 2015 18:11:41 +0700
Subject: [PATCH] pci: acpi: Generic function for setting up PCI device DMA
 coherency
In-Reply-To: <CAErSpo6TcwVH+TT5wZnLjOPMTa1NBoN=qJCev1rg1n_xFbggBQ@mail.gmail.com>
References: <1439459925-2361-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150814015004.GA26431@google.com>
 <CAErSpo7yN08tKyo-yyyVG58vUptbHGN=L+MEZ8TQy1gm5a1_0Q@mail.gmail.com>
 <55DB6BF6.1030206@amd.com>
 <CAErSpo6TcwVH+TT5wZnLjOPMTa1NBoN=qJCev1rg1n_xFbggBQ@mail.gmail.com>
Message-ID: <55DC4D6D.207@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On 8/25/2015 3:14 AM, Bjorn Helgaas wrote:
> On Mon, Aug 24, 2015 at 12:09 PM, Suravee Suthikulpanit
> <Suravee.Suthikulpanit@amd.com> wrote:
>
>>>> commit 84cfb2213cd400fef227ec0d7829ec4e12895da9
>>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>>> Date:   Thu Aug 13 19:49:52 2015 -0500
>>>>
>>>>       ACPI / scan: Rename acpi_check_dma() to acpi_dma_is_coherent()
>>>>
>>>>       The name "acpi_check_dma()" doesn't give any much indication about
>>>> what
>>>>       exactly it checks.  The function also returns information both as a
>>>> normal
>>>>       return value and as the "bool *coherent" return parameter.  But
>>>> "*coherent"
>>>>       doesn't actually give any extra information: it is unchanged when
>>>> returning
>>>>       false and set to true when returning true.
>>>>
>>>>       Rename acpi_check_dma() to acpi_dma_is_coherent() so the callers
>>>> read more
>>>>       naturally.  Drop the return parameter and just use the function
>>>> return
>>>>       value.
>>>>
>>>>       Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>
>> This was because, at one point, we wanted to be able to differentiate
>> between the case _CCA=0 and missing _CCA in ARM64, where we would support
>> DMA (using arch-specific cache maintenance) if _CCA=0, and disable DMA when
>> missing _CCA on ARM64.
>>
>> It seems like the logic is now required (please see
>> https://www.mail-archive.com/linux-usb at vger.kernel.org/msg62735.html). So,
>> we would need the true/false return, and the coherent variable to be able to
>> differentiate between the two cases.
>>
>> Please let me know what you think.
>
> It's hard for me to comment without seeing the actual patches.  I
> think returning two values (_CCA-seen and coherent) is a confusing
> interface.

Ok. Let me simplify this and send out V2.

Thanks,
Suravee

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
