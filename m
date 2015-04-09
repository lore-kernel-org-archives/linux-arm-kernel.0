From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 9 Apr 2015 14:14:37 +0200
Subject: [PATCH v3 3/5] arm64: Documentation: clarify Image placement in
 physical RAM
In-Reply-To: <20150409115417.GD18488@leverpostej>
References: <1426698308-726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426698308-726-4-git-send-email-ard.biesheuvel@linaro.org>
 <20150409115417.GD18488@leverpostej>
Message-ID: <CAKv+Gu9AnYxRisCenSE=ydd9wx7JPTqCogu2R4+ZzU4N6LUHng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2015 at 13:54, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> I take it that this (and patch 4) are superseded by the single-page
> idmap approach, and when this is next posted you'll fold the series?
>

indeed.

-- 
Ard.


> On Wed, Mar 18, 2015 at 05:05:06PM +0000, Ard Biesheuvel wrote:
>> The early init code maps the kernel image using statically
>> allocated page tables. This means that we can only allow
>> Image to be placed such that we can map its entire static
>> footprint using a single table entry at all but the lowest
>> level. So update the documentation to reflect that the Image
>> should not cross a 512 MB boundary, which ensures the above
>> on both 4k and 64k pages kernels.
>>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/arm64/booting.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
>> index ab5a90adece3..5949bdbe7aac 100644
>> --- a/Documentation/arm64/booting.txt
>> +++ b/Documentation/arm64/booting.txt
>> @@ -115,8 +115,9 @@ The Image must be placed text_offset bytes from a 2MB aligned base
>>  address near the start of usable system RAM and called there. Memory
>>  below that base address is currently unusable by Linux, and therefore it
>>  is strongly recommended that this location is the start of system RAM.
>> -At least image_size bytes from the start of the image must be free for
>> -use by the kernel.
>> +The physical memory region consisting of image_size bytes counting from
>> +the start of the image must be free for use by the kernel, and must not
>> +cross a 512 MB physical alignment boundary.
>>
>>  Any memory described to the kernel (even that below the 2MB aligned base
>>  address) which is not marked as reserved from the kernel e.g. with a
>> --
>> 1.8.3.2
>>
>>
