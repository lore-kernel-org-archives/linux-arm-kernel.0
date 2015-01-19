From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 19 Jan 2015 11:29:55 -0800
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAAObsKA9EgdmqAe8JxJ=8nKJy6MsenHv8cpDO6fBiutBtgEpGw@mail.gmail.com>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <CAAObsKA9EgdmqAe8JxJ=8nKJy6MsenHv8cpDO6fBiutBtgEpGw@mail.gmail.com>
Message-ID: <CAL1qeaE_cbKnpxU8qvySyLwq1dkU+7D5vZ6-YFX2_66ntqcnBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu

On Mon, Jan 19, 2015 at 1:01 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
> On 13 August 2014 at 03:56, Dylan Reid <dgreid@chromium.org> wrote:
>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>> processor and is similar to the Venice2 reference platform.
>>
>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>> and work on the 1366x768 models.  I haven't tried on the HD systems
>> yet.
>>
>> WiFi does not yet work, it needs at least some PMIC changes to enable
>> the 32k clock.
>>
>> The elan trackpad is not yet functional but hopefully will be soon as
>> there are patches under review.
>>
>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press refresh and power at the same time.
>
> Hi Dylan,
>
> do you have any more information regarding this problem that could
> save me some investigation?

The PMC reset does not reset the TPM, so the reset pin (GPIO I5) must
be toggled instead.

-Andrew
