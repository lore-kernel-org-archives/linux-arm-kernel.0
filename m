From: dgreid@chromium.org (Dylan Reid)
Date: Thu, 4 Sep 2014 13:33:09 -0700
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <5408C023.8060403@wwwdotorg.org>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <5408C023.8060403@wwwdotorg.org>
Message-ID: <CAEUnVG5xdbGZS5pFef0mkCB15pCCFR=vW5rELwU--KTBCT_feQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 12:40 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2014 01:14 PM, Dylan Reid wrote:
>>
>> The Acer Chromebook 13, codenamed Big, contains an NVIDIA tegra124
>> processor and is similar to the Venice2 reference platform.
>>
>> The keyboard, USB 2, audio, HDMI, sdcard, and emmc have been tested
>> and work on the 1266x768 models.  The HD models haven't yet been
>> tested.
>>
>> WiFi does not work yet, it needs at least some PMIC changes to enable
>> the 32k clock.
>>
>> The elan trackpad is not yet functional but hopefully will be soon as
>> there are patches under review.
>>
>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press the refresh and power keys at the same
>> time.
>
>
> BTW, I'm only waiting on a few minor fixes for issues pointed out by Andreas
> before applying this patch:

Thanks Stephen,

Sorry I've been MIA, things have been a little crazy here.

> * Resolution typo in the commit message.
> * Sort order of the Makefile addition.
> * pwm: label move.

If I move the pwm label, should I move the others as well?  Do we want
to use the same method that has been used for exynos5250?  Exynos has
a label on most things that are overridden and the .dts files that
override them, like exynos5250-snow.dts, access them with &label
syntax.  It's easy for me to do, but it will involve converting
venice2 and jetson as well to avoid label re-defines.

> * Stray content/syntax error in regulator at 1 node.
>
> I'm assuming you'll repost for that? I guess I could fix them up when
> applying, but I usually wouldn't.
