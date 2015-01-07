From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 7 Jan 2015 11:53:38 +0000
Subject: [PATCH 2/8] arm64/efi: register UEFI reserved regions as iomem
 resources
In-Reply-To: <20150106091322.GG3163@console-pimps.org>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419275322-29811-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150106091322.GG3163@console-pimps.org>
Message-ID: <CAKv+Gu9T0yQXGMSj_+=f7v54OO=1YqAKi0s0m3Vj0Y0Ea---1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2015 at 09:13, Matt Fleming <matt@console-pimps.org> wrote:
> On Mon, 22 Dec, at 07:08:36PM, Ard Biesheuvel wrote:
>> To prevent device drivers from attaching to device or memory regions
>> owned by the firmware, register all UEFI reserved regions in the iomem
>> resource table at init time.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/efi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>
> Looks nice.
>
> Just curious, have you actually seen drivers trying to claim these
> regions?
>

Yes. RTC and NOR flash in particular, which should not appear in the
device tree in the first place if the firmware owns them, but let's
not assume all firmware vendors will get that right first try,
