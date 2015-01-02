From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Jan 2015 16:47:51 +0000
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54A664AB.3030101@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-19-git-send-email-hanjun.guo@linaro.org>
 <CAJ5Y-eZ5cu9_OhG24yAv+CZq7zKg0vU+eVGekyN+9dDzaz1OhQ@mail.gmail.com>
 <8fc9550c96a468b3e50d51a37db68a33.squirrel@www.codeaurora.org>
 <54A3B526.9040903@linaro.org>
 <20150101200424.GB12770@xora-haswell.xora.org.uk>
 <54A664AB.3030101@linaro.org>
Message-ID: <EE1B062D-90AC-491F-90E7-D7EACF1F5B06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 Jan 2015, at 09:28, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> On 2015?01?02? 04:04, Graeme Gregory wrote:
>>>> On Wed, Dec 31, 2014 at 04:34:46PM +0800, Hanjun Guo wrote:
>>>> On 2014?12?31? 04:13, ashwinc at codeaurora.org wrote:
>>>> Hi Hanjun,
>>>> 
>>>> Overall the document looks good to us. Some minor clarifications below.
>>>> 
>>>>> ---------- Forwarded message ----------
>>>>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>>>> 
>>>>> Add documentation for the guidelines of how to use ACPI
>>>>> on ARM64.
>>>>> 
>>>>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>>>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>>> ---
>>>>> Documentation/arm64/arm-acpi.txt |  323
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>> 1 file changed, 323 insertions(+)
>>>>> create mode 100644 Documentation/arm64/arm-acpi.txt
>>>> 
>>>> [..]
>>>> 
>>>>> +Relationship with Device Tree
>>>>> +-----------------------------
>>>> 
>>>> [..]
>>>> 
>>>>> +When booting using ACPI tables, the /chosen node in DT will still be
>>>>> parsed
>>>>> +to extract the kernel command line and initrd path.  No other section of
>>>>> the
>>>>> +DT will be used.
>>>> 
>>>> Is this still true?
>>> 
>>> No, we can booting the ACPI system in EFI stub without dtb. Catalin
>>> also pointed out this issue, I will remove this paragraph.
>> 
>> The paragraph is still correct, the /chosen node is always present even
>> if nothing else is.
> 
> Sorry for the confusing, I mean no dtb needed for the command line if
> ACPI tables are available.
> 
> efi will create a empty dtb if no dtb found, and add the cmd line into
> the new created dtb, I'm just wondering, can we remove the limitation
> for passing the cmd line in /chosen node in the future?

My point is that on an ACPI based system, we don't really care how EFI_STUB passes
the command line to the rest of the kernel. Since UEFI doesn't need to know about
such detail and since ACPI is only supported with EFI_STUB, we don't need to mention
the chosen node in this document. 

At some point we may even change the way EFI_STUB passes the command line to the 
kernel but this is still irrelevant to ACPI. 

Catalin
