From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Feb 2013 13:15:45 +0100
Subject: [PATCH v8 02/12] gpio: fix wrong checking condition for gpio range
In-Reply-To: <1360602659-4774-3-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYDCf4R-birQKVvRkYtXrOKEXNchMQ-wKAd6uJxGH=2Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> If index++ calculates from 0, the checking condition of "while
> (index++)" fails & it doesn't check any more. It doesn't follow
> the loop that used at here.
>
> Replace it by endless loop at here. Then it keeps parsing
> "gpio-ranges" property until it ends.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Grant can you pick this patch (and the other one, 01/12)?

I would stack them in my tree unless there was such deep-core
OF business involved, which makes me insecure.

Yours,
Linus Walleij
