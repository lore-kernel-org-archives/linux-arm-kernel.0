From: keescook@chromium.org (Kees Cook)
Date: Wed, 19 Oct 2016 13:14:08 -0700
Subject: [PATCH 1/2] efi: add support for seeding the RNG from a UEFI
 config table
In-Reply-To: <20161019112243.GD31476@codeblueprint.co.uk>
References: <1475749646-10844-1-git-send-email-ard.biesheuvel@linaro.org>
 <1475749646-10844-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161019110926.GG9616@leverpostej>
 <CAKv+Gu9g1W8EfnJN2Y_Xgo=QKC1gHa95rjO32Dqt4uT+amzhnQ@mail.gmail.com>
 <20161019112243.GD31476@codeblueprint.co.uk>
Message-ID: <CAGXu5jJ-KTVJLwAp6iZ-tp5AKnAzSHz80yZkg4dh3uYDz3MsJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 4:22 AM, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Wed, 19 Oct, at 12:13:55PM, Ard Biesheuvel wrote:
>> On 19 October 2016 at 12:09, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> > I think to some extent this mush be treated as an ABI, given cases like
>> > kexec.
>> >
>>
>> Perhaps, yes. That would also allow GRUB or other EFI aware
>> bootloaders to generate the seed.
>
> If we're going to go down this route, we should try and get the GUID
> into the UEFI spec.

It seems like maybe under UEFI, both this table (which sounds like
it'll not be rotated regularly) could be mixed with calls to
EFI_PROTOCOL_RNG by the kernel? (Similar to how kaslr is seeded?)

-Kees

-- 
Kees Cook
Nexus Security
