From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Tue, 2 Dec 2014 14:12:48 +0000
Subject: [PATCH 1/2] arm64: amd-seattle: Fix dma-ranges property
In-Reply-To: <2316008.jChdsJ8v0y@wuerfel>
Message-ID: <D0A3B11F.AAC8%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 12/1/14, 20:33, "Arnd Bergmann" <arnd@arndb.de> wrote:

>On Sunday 30 November 2014 21:46:39 suravee.suthikulpanit at amd.com wrote:
>> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> 
>> AMD Seattle should support 40-bit DMA.
>> 
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> 
>
>The change looks good, but two things about the patch description:
>
>- You should be a little more verbose, especially after we had discussed
>  this to some detail on IRC, explain why you use the specific values.

Would you minding adding the following detail in the commit message?

- BEGIN -
AMD Seattle supports 40-bit DMA, which includes two ranges:
    1. GICv2m MSI register frame at 0xe0080000
    2. DRAM range [0x8000000000 to 0xffffffffff]

Since the current parsing logic handles only single range, this patch
specifies the range from zero to 0x10000000000 to cover the whole
40-bit range.

However, it expects DMA allocation/mapping logic to check the specified
DMA range against the reported DRAM range, which starts from
0x8000000000 in this case.
- END -

>
>- You should configure git-send-email to know your full email address
>  including the name. Right now it gets sent from
>  "suravee.suthikulpanit at amd.com" instead of "Suravee Suthikulpanit
>  <Suravee.Suthikulpanit@amd.com>", and that causes the extra From
>  line at the start of the mail, besides looking a bit strange.

Thanks for the pointer. I didn?t notice that. I?ll fix that for the future.

Suravee
>
>Thanks,
>
>	Arnd
