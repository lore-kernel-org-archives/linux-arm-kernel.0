From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 10:02:37 +0200
Subject: [PATCH] arm64/efi: set PE/COFF file alignment to 512 bytes
In-Reply-To: <20141021123526.GH12020@console-pimps.org>
References: <1412960335-22905-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141021123526.GH12020@console-pimps.org>
Message-ID: <CAKv+Gu-V-pSDTQuBOV_zK3YvuQoyFC7mXLXs91iQavM0sbytEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2014 14:35, Matt Fleming <matt@console-pimps.org> wrote:
> On Fri, 10 Oct, at 06:58:55PM, Ard Biesheuvel wrote:
>> Change our PE/COFF header to use the minimum file alignment of
>> 512 bytes (0x200), as mandated by the PE/COFF spec v8.3
>>
>> Also update the linker script so that the Image file itself is also a
>> round multiple of FileAlignment.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> Another one from the PE/COFF rabbit hole. I will follow up next week and repost
>> as a coherent series, once I have collected all the feedback.
>
> It appears a though next week never came.
>
> Should I pick up this version and apply ACK tags from the mailing list?
> Or are you planning on sending a larger series?
>
> It sounds like this should be tagged for stable, and placed into the EFI
> urgent queue?
>

I have a couple of patches like this one in my queue, and I don't
think any of them are urgent. These alignment fixes etc are mainly for
full compliance with the various specs, and there are no known issues
being solved by them.

I was going to wait for -rc1 and rebase on top of that, but it appears
your branch hasn't been picked up?

-- 
Ard.
