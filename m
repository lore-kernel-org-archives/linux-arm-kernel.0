From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 1 Feb 2016 17:29:22 +0100
Subject: [PATCH V13 09/10] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56AF84F4.2080809@codeaurora.org>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-10-git-send-email-okaya@codeaurora.org>
 <56AF82FA.7000303@linaro.org> <56AF84F4.2080809@codeaurora.org>
Message-ID: <56AF87E2.8040201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2016 05:16 PM, Sinan Kaya wrote:
> On 2/1/2016 11:08 AM, Eric Auger wrote:
>>> For ACPI systems, ACPI HID needs to match and compat in the registered
>>>> reset
>>>> driver needs to match for ACPI reset driver loading to work.
>> Don't really get the sentence. For ACPI systems, a registered reset
>> function is selected if its associated ACPI HID matches the device ACPI HID?
> 
> Old commit message. I did an internal review before posting the patch. The first
> version of the patch was a hack. I simplified the code but forgot to update the 
> commit message.
> 
> Now, the rule is simple.
> 
> - ACPI HID needs match for ACPI systems
> - DT compat needs to match for OF systems
> 
> as expected. I'll rephrase for the next version.
> 
>>>>
>>>> For OF based systems, DT compatible string needs to match and compat in the
>>>> registered reset driver needs to match for DT reset driver loading to work.
>> same here
>>
>> I added Baptiste who is vfio platform driver sub-system maintainer.
> 
> Thanks, we should ask Baptiste to get his email into the Maintainer file list.
I think it is:
./scripts/get_maintainer.pl
0001-vfio-platform-add-support-for-ACPI-while-detecting-t.patch

Baptiste Reynal <b.reynal@virtualopensystems.com> (maintainer:VFIO
PLATFORM DRIVER,commit_signer:1/5=20%)
Alex Williamson <alex.williamson@redhat.com> (maintainer:VFIO
DRIVER,commit_signer:2/3=67%,commit_signer:4/5=80%)
../..
> 
>>
>> On my side I tested with of amd xgbe and I don't observe any regression.
>>
>> Best Regards
> 
> Can I add your tested by?
Well to make things clear I did not test the ACPI part. I just can tell
this does not bring any regression on the of part. But I am not against
if you don't find anybody else and you tested the ACPI part ;-)

Best Regards

Eric
> 
