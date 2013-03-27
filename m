From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 11:20:28 +0100
Subject: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
In-Reply-To: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 8:22 AM, Barry Song <Barry.Song@csr.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> hardcode set i2c pin group to i2c function before, here we
> move to use standard pinctrl API to get pins of the group.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

NAK.

This is done by the device core as of commit
ab78029ecc347debbd737f06688d788bd9d60c1d
"drivers/pinctrl: grab default handles from device core".

You only need to fetch pinctrl handles in drivers if you're
using anything else than the default state.

Yours,
Linus Walleij
