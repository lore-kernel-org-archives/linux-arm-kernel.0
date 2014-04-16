From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 16 Apr 2014 13:24:25 -0700
Subject: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
In-Reply-To: <534EAD91.90704@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-5-git-send-email-abrestic@chromium.org>
 <CAL1qeaGGSs5fpqrKWA4u4+RXRy9Ko2pN=s9QQdbXAfLG3ujR8g@mail.gmail.com>
 <534EAD91.90704@wwwdotorg.org>
Message-ID: <CAL1qeaENYazDf6cuWsFLgJcsAPTU9D4nz1dPr3Jva_++Po_mrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 9:19 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/15/2014 06:29 PM, Andrew Bresticker wrote:
>>>         sdhci at 0,700b0600 {
>>>                 status = "okay";
>>>                 bus-width = <8>;
>>> +               vqmmc-supply = <&vddio_1v8>;
>>
>> It turns out this bit isn't needed as the initialization failures are
>> instead due to +3V3_RUN toggling, which Stephen has fixed:
>> http://patchwork.ozlabs.org/patch/339386/
>
> Indeed, if I apply patches 1, 2, and 4 from this series, revert the hunk
> above, apply my Venice2 regulator patch, and finally apply your AS3722
> regulator GPIO patch, then everything works fine for me:-)

Great, I'll fix up and resend without patch 3 as it looks like that
will need some more work.
