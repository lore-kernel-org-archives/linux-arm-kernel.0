From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 15:24:07 +0100
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
Message-ID: <bb444c46-b9a1-ad33-51a5-01d838494e07@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 28/06/18 11:25, Ard Biesheuvel wrote:
> I understand the desire to keep running these M400s as long as they
> have some life left in them, but the reality is that they are end of
> life already, and not many were manufactured to begin with.

Sure, all this would really avoid is users having to specify 'disable_hest' on
the cmdline. If these things are as rare as they sound, all the users are
probably experts quite capable of doing this, and must have been doing this
since v4.13.

[...]

> As for the efi.h patch: I don't object to adding code that makes the
> spec revision available, but note that this is *not* a firmware build
> number, and so it should not be used as such.

Ah, I thought it was, from:
| efi.runtime_version = efi.systab->hdr.revision;

I read this like an ACPI OEM revision, which obviously its not.
(its was also motivated by something I can pick out of dmesg on the bug reports)

So this is the wrong thing to do. Matching BIOS build dates is clearly silly,
and doesn't scale to a range.


> Also, given that m400 is
> EOL and unmaintained, no firmware updates are expected, and so
> assuming that there will be a UEFI 2.7 based update in the future
> seems rather optimistic.

Not just a future release (although I am forever optimistic), but I was trying
not to match older versions without evidence that they are affected.

I mistakenly thought this was something approximating a firmware build version.


Thanks,

James
