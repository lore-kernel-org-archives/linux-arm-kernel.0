From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 7 Jun 2017 21:14:51 +0200
Subject: [PATCH 0/3] arm64: hi6220-hikey: Fix Bluetooth support
In-Reply-To: <CALAqxLVYH8+shjfxkjr5uFzKLznqtRZq2noEa9mcZET9hBNf2g@mail.gmail.com>
References: <1496826502-1339-1-git-send-email-ulf.hansson@linaro.org>
 <CALAqxLVYH8+shjfxkjr5uFzKLznqtRZq2noEa9mcZET9hBNf2g@mail.gmail.com>
Message-ID: <738b3232-d725-1642-3c54-374b4d159b62@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 21:07, John Stultz wrote:
> On Wed, Jun 7, 2017 at 2:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The commit ea452678734e ("arm64: dts: hikey: Fix WiFi support") indeed managed
>> to fix the WiFi support for the Hikey board. However, it also caused the
>> Bluetooth to break.
>>
>> The reason to the problem is because part of the fixes for WiFi, involved
>> explicitly to start manage the external clock for the TI WiLink chip, as it's
>> needed to properly power on/off WiFi. Then, because the Bluetooth driver,
>> hci_ll, don't manage the clock, it fails to initialize Bluetooth.
>>
>> This small series add support and DT bindings for the external clock, now
>> properly managed by the hci_ll driver during power on/off. On top of that, the
>> external clock is added to the Bluetooth DT node in the Hikey DTS file.
>>
>> The regression has been reported by John Stultz, running a Hikey board with
>> UEFI based boot. I have confirmed that there is no regressions with u-boot as
>> we still don't have bluetooth working on that set up. I intend to fix that as
>> well, although in second step and not being part of a fixup series.
>>
>> John, can you please confirm/test this on your Hikey board using UEFI!?
> 
> Yes. This does resolve the issue! Bluetooth and wifi are now working
> together again as they were before ea452678734e.
> 
> For the whole set:
> Tested-by: John Stultz <john.stultz@linaro.org>

Great ! Thanks John for testing.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
