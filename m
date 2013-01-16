From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 16 Jan 2013 09:54:19 +0100
Subject: [PATCH 0/3] clk: Provide option to unprepare unused clocks at
 late init
In-Reply-To: <CACRpkdbCuDxszPZ-VYxhbNUSvyGM=rGw4h5Uy8LfqDcY0V-Dyg@mail.gmail.com>
References: <1355872583-20928-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdbCuDxszPZ-VYxhbNUSvyGM=rGw4h5Uy8LfqDcY0V-Dyg@mail.gmail.com>
Message-ID: <CAPDyKFq+xQPnyXX-N7Wnst-8YCtcVCLcz8Z0T4jGJKD2KmvTBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 December 2012 20:17, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Dec 19, 2012 at 12:16 AM, Ulf Hansson
> <ulf.hansson@stericsson.com> wrote:
>
>> The disable_unused sequence executed at late init, is already handling the
>> fast unused ungated clocks to be gated. This patchset extends this sequence to
>> include the slow unused prepared clocks to be unprepared.
>>
>> The default behavior will not change in this patchset. To unprepare unused
>> clocks during the disable_unused sequence, the clk_hw needs to implement
>> the new optional callback, is_prepared.
>>
>> The motivation for this patchset is to save power. Clocks that is from
>> bootloaders prepared|enabled, but not used should be unprepared|disabled.
>
> This has a nice symmetrical touch to it and looks allright to me, so
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Hi Mike,

Just a kind reminder on this, could this be merged for 3.9?

I have a patch for ux500 that make use of this new feature, so it is
of course fully tested.
My plan was to send this patch separately, but if you like to see a
"proof of concept" I can include it into this patchset!?

Thanks!
Ulf Hansson
