From: kdinh@apm.com (Khuong Dinh)
Date: Tue, 25 Apr 2017 11:31:44 -0700
Subject: [PATCH v4 00/21] PCI: fix config space memory mappings
In-Reply-To: <000101d2bddf$cd442e80$67cc8b80$@gmail.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <2e24e205-d761-9172-9463-4a53e1a0de4d@jonmasters.org>
 <000101d2bddf$cd442e80$67cc8b80$@gmail.com>
Message-ID: <CAAsHzqvQ2H76UXdmrxVvSnbkEn1naZAwbMOQXkJMgSt9Vr2xvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack.
Tested-by: Khuong Dinh <kdinh@apm.com>


On Tue, Apr 25, 2017 at 9:20 AM, Jingoo Han <jingoohan1@gmail.com> wrote:
> On Tuesday, April 25, 2017 2:41 AM, Jon Masters wrote:
>>
>> On 04/19/2017 12:48 PM, Lorenzo Pieralisi wrote:
>>
>> > On some platforms (ie ARM/ARM64) ioremap fails to comply with the PCI
>> > configuration non-posted write transactions requirement, because it
>> > provides a memory mapping that issues "bufferable" or, in PCI terms
>> > "posted" write transactions. Likewise, the current pci_remap_iospace()
>> > implementation maps the physical address range that the PCI translates
>> > to I/O space cycles to virtual address space through pgprot_device()
>> > attributes that on eg ARM64 provides a memory mapping issuing
>> > posted writes transactions, which is not PCI specifications compliant.
>>
>> Side note that I've pinged all of the ARM server vendors and asked them
>> to verify this patch series on their platforms.
>
> Good! I really want to know the result of these patches on ARM serves.
> Please share it with us. Good luck.
>
> Best regards,
> Jingoo Han
>
>>
>> Jon.
>
>

-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
