From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 12 Jan 2015 15:43:24 +0100
Subject: [PATCH 0/4] mmc: core: Add support for MMC power sequences
In-Reply-To: <CAAObsKDXTwmXQ_oviSv4jyvaVepgsw8g5VJNpt1X=JCzfpTYuw@mail.gmail.com>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
 <CAAObsKDXTwmXQ_oviSv4jyvaVepgsw8g5VJNpt1X=JCzfpTYuw@mail.gmail.com>
Message-ID: <CAPDyKFoXxCT8uED3SxY9e1N6HhRyk1RGwpHOHRtzUY5vcBtcYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 January 2015 at 15:26, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 2 January 2015 at 17:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> This is yet another try to solve the issues of dealing with power sequences for
>> the MMC subsystem. The latest attempt, see link below, took a generic approach
>> by adding a new top level driver layer. That's was rejected by several reasons.
>> http://lwn.net/Articles/602855/
>>
>> This time the approach is focused to fix the issues for MMC only.
>>
>> To give a short background, SOCs may specify a specific MMC power sequence. To
>> successfully detect an (e)MMC/SD/SDIO card, that power sequence must be followed
>> while initializing the card.
>
> Hi Ulf,
>
> have used this to successfully init a mwifiex_sdio card but had to
> also add a delay while the reset line is asserted. May make sense to
> add a property to the pwrseq node to specify the minimum amount of
> time that the reset GPIO needs to be asserted?

To me that is description of the HW, so I would happily accept such a
DT property. Can you please send a patch, based on top of this
patchset?

BTW, I guess you only need the delay while the ->power_up() callback
is invoked and not for ->power_off()?

>
> Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks for helping out testing!

Kind regards
Uffe
