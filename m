From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 4 Mar 2016 11:34:10 -0800
Subject: [PATCH 0/3] ACPI: parse the SPCR table
In-Reply-To: <67709E22-E82E-40BA-A271-2107608F4EF3@redhat.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <56A6494E.3090303@hurleysoftware.com> <56A8B570.2060501@linaro.org>
 <56BBCA2F.3020604@redhat.com> <56D899C4.5050802@hurleysoftware.com>
 <67709E22-E82E-40BA-A271-2107608F4EF3@redhat.com>
Message-ID: <56D9E332.2000005@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

[ cc'd everyone back in on the assumption private mail was accidental ]


On 03/04/2016 12:21 AM, Jon Masters wrote:
> Top posting - in transit currently
> 
> Peter,
> 
> I would like to understand what concrete action you feel is needed in
> order to be comfortable with adding SPCR support to the Linux
> kernel?
>
> To clarify for others - this thread pertains to perceived issues with
> the license of a document describing the format of the SPCR, a
> document whose license was explicitly changed in response to previous
> concerns raised by yourself, not the code that actually implements
> SPCR support.

Not exactly, because there is no such thing as patenting a document.

The specification purports that patents apply to implementations of
SPCR, and grants rights to those patents under two optional licenses.

What I want is what is expected of any submitter to the Linux Kernel:
that the submitter has the legal right to do so as spelled out
in the Developer's Certificate of Origin (the text of which is in
Documentation/SubmittingPatches).

To have the legal right to submit material to which patents apply
requires a license.

So either
A) the submission does not infringe, and no patent license is required, or
B) the submission requires a patent license because otherwise it would
infringe.

If A, what I would like to see is the due diligence as to why the
submission does not infringe.

If B, FSF maintains an online list of GPL compatible licenses.
Neither of the two licenses offered are on the FSF online list.

The FSF also maintains a compliance lab and will render opinions on
the GPL compatibility of a license. They can be reached at
licensing at fsf.org

Alternatively, a statement from Linux Foundation that this
has been discussed and agreed upon privately is also fine.

Alternatively, any sign-off from ARM, Linaro or Red Hat legal that either
a) one of those licenses is GPL compatible, or
b) the submission does not infringe on the purported patents (and why)


> However you retain the opinion that the license under which the table
> is published "is not GPL compatible". So under what license would you
> like to see this table specification released?

Assuming none of the options above is acceptable, any license in the
"GPL-Compatible Free Software Licenses" listed here:

http://www.gnu.org/licenses/license-list.en.html#GPLCompatibleLicenses



> Jon.
> 
> -- Computer Architect | Sent from my 64-bit #ARM Powered phone
>> > On Mar 4, 2016, at 05:08, Peter Hurley <peter@hurleysoftware.com> wrote:
>> > 
>> > Hi Al,
>> > 
>> > Somehow your email was filtered. Apologies for that.
>> > 
>>> >> On 02/10/2016 03:39 PM, Al Stone wrote:
>>>> >>> On 01/27/2016 05:17 AM, Aleksey Makarov wrote:
>>>> >>> 
>>>> >>> 
>>>>> >>>> On 01/25/2016 07:11 PM, Peter Hurley wrote:
>>>>>> >>>>> On 01/25/2016 03:45 AM, Aleksey Makarov wrote:
>>>>>> >>>>> This patchset is based on the patchset by Leif Lindholm [1]
>>>>>> >>>>> 
>>>>>> >>>>> 'ARM Server Base Boot Requirements' [2] mention SPCR 
>>>>>> >>>>> (Serial Port Console Redirection Table) [3] as a mandatory
>>>>>> >>>>> ACPI table that specifies the configuration of serial console.
>>>>>> >>>>> 
>>>>>> >>>>> Licensing concerns have prevented implementing it in the past, but as of
>>>>>> >>>>> 10 August 2015, these tables have both been released also under 
>>>>>> >>>>> OWF 1.0 [4].
>>>>> >>>> 
>>>>> >>>> This license has a patent retaliation provision, which makes it
>>>>> >>>> incompatible with GPLv2.
>>>>> >>>> 
>>>>> >>>> *If the license applies to this code*, then this patch set does not
>>>>> >>>> meet the criteria for submission.
>>>> >>> 
>>>> >>> The license applies not to this code but to the document describing the tables.
>>> >> 
>>> >> Just for the record, the SPCR table struct definition has been part
>>> >> of the Linux kernel since at least commit b24aad44 on 2009-07-24
>>> >> (line 1112 of include/acpi/actbl2.h) -- or so git blame tells me.
>> > 
>> > Just to be clear here:
>> > 
>> > The Microsoft specification, which defines the SPCR table struct and which
>> > this patch series relies on, notes that patents apply. Specifically, it
>> > says:
>> > 
>> > Patent Notice:
>> > Microsoft is making certain patent rights available for implementations of this specification under two options:
>> > 1)  Microsoft?s Community Promise, available at http://www.microsoft.com/openspecifications/en/us/programs/community-promise/default.aspx; or
>> > 2)  The Open Web Foundation Final Specification Agreement Version 1.0 ("OWF 1.0") as of October 1, 2012, available at http://www.openwebfoundation.org/legal/the-owf-1-0-agreements/owfa-1-0. 
>> > Version 1.03 ? August 10, 2015
>> > 
>> > I don't believe either of those patent licenses are GPL compatible.
>> > 
>> > Unless you're saying Red Hat is signing off on this?
>> > 
>> > Regards,
>> > Peter Hurley
