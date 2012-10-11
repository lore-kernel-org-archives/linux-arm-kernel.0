From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Oct 2012 15:52:03 +0200
Subject: [PATCH 04/16] pinctrl: samsung: Parse pin banks from DT
In-Reply-To: <1983938.6eHV2XjAIK@amdc1227>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-5-git-send-email-t.figa@samsung.com>
 <CACRpkdafuxbO_peOBgmrjXk7ioVBF6D-D7d=shUd-GpHOdNxqg@mail.gmail.com>
 <1983938.6eHV2XjAIK@amdc1227>
Message-ID: <CACRpkdZsfNgckwKHWTf5xM+SHUr_tKbCHLyDDYef8QM6XWAcUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> On Wednesday 10 of October 2012 09:34:05 Linus Walleij wrote:

>> If you will end up with a hybrid approach with some
>> stuff in the device tree and some stuff in the code,
>> it's better to keep the old driver.
>
> This will allow us to cover all the existing Samsung SoCs, starting from
> S3C24xx, through S3C64xx, S5P*, all supported Exynos SoCs and ending on any
> future SoCs using this kind of pin controller, without bloating the driver
> with hardly readable macros, lots of (often duplicated) static data and
> similar.

I do not agree with this, as you probably have realized by now...

I think it's better to use the compatible string to choose the offset
variable directly in the driver. But hey, it's just me, still.

> If there are some serious problems with this approach, just let me know and
> I will reconsider it, but if not, I'd like to keep it, because of the
> benefits it gives.

I'd like some input from Thomas Abraham before I make up my
mind about it.

Yours,
Linus Walleij
