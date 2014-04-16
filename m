From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 10:19:29 -0600
Subject: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
In-Reply-To: <CAL1qeaGGSs5fpqrKWA4u4+RXRy9Ko2pN=s9QQdbXAfLG3ujR8g@mail.gmail.com>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>	<1397526163-20126-5-git-send-email-abrestic@chromium.org>
 <CAL1qeaGGSs5fpqrKWA4u4+RXRy9Ko2pN=s9QQdbXAfLG3ujR8g@mail.gmail.com>
Message-ID: <534EAD91.90704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 06:29 PM, Andrew Bresticker wrote:
>>         sdhci at 0,700b0600 {
>>                 status = "okay";
>>                 bus-width = <8>;
>> +               vqmmc-supply = <&vddio_1v8>;
> 
> It turns out this bit isn't needed as the initialization failures are
> instead due to +3V3_RUN toggling, which Stephen has fixed:
> http://patchwork.ozlabs.org/patch/339386/

Indeed, if I apply patches 1, 2, and 4 from this series, revert the hunk
above, apply my Venice2 regulator patch, and finally apply your AS3722
regulator GPIO patch, then everything works fine for me:-)
