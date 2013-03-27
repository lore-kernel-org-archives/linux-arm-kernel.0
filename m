From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 16:14:39 +0100
Subject: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
In-Reply-To: <CAGsJ_4xN6=1myOVyz6wTagd=JCvGgta1q4wwq0RFE0XcDokoSA@mail.gmail.com>
References: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdbg=ii1XjUmVd7GOOWF_FAMq_uUcvaGstbWjiGWGEbFLQ@mail.gmail.com>
 <CAGsJ_4xN6=1myOVyz6wTagd=JCvGgta1q4wwq0RFE0XcDokoSA@mail.gmail.com>
Message-ID: <CACRpkdb=ku7fEtx7w4uJ4JGHqovVQbBK9yJt=okDXdFUYaKnLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 11:36 AM, Barry Song <21cnbao@gmail.com> wrote:
> 2013/3/27 Linus Walleij <linus.walleij@linaro.org>:

>> You only need to fetch pinctrl handles in drivers if you're
>> using anything else than the default state.
>
> well. missed this recent commit.
> it should mean we hould drop all devm_pinctrl_get_select_default() if
> the driver only takes the default pinctrl?

Yes.

> it looks like there are still a lot of drivers doing that. anyway, i
> will drop them in SiRFsoc drivers. and involve you in the coming
> patch.

I am meaning to fix that up. Just haven't had time to...
Prior to that patch it was the right thing to do.

Yours,
Linus Walleij
