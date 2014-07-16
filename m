From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Jul 2014 15:31:54 -0700
Subject: [PATCH v2] i2c: s3c2410: resume the I2C controller earlier
In-Reply-To: <20140716173528.GF2759@katana>
References: <1403654214-25072-1-git-send-email-dianders@chromium.org>
 <20140716173528.GF2759@katana>
Message-ID: <CAD=FV=W6OCzXOE9gz9qxGggiVeTHiveg7W-1hnF3_-OKy7RLKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

On Wed, Jul 16, 2014 at 10:35 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Jun 24, 2014 at 04:56:54PM -0700, Doug Anderson wrote:
>> From: Vincent Palatin <vpalatin@chromium.org>
>>
>> When the wake-up is triggered by the PMIC RTC, the RTC driver is trying
>> to read the PMIC interrupt status over I2C and fails because the I2C
>> controller is not resumed yet.
>> Let's resume the I2C controller earlier in the _noirq phase
>> (as other hardwares are doing), so we can properly get the wake-up
>> condition.
>>
>> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
> Applied to for-current (because Tomasz said it fixes issues), thanks! If
> you think the exynos patch of the same style should also be in current,
> please let me know...

Thanks!  I don't think the exynos one needs to go into for-current.
for-next is enough.  :)

-Doug
