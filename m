From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 15:07:32 +0200
Subject: [PATCH 1/2] input: keypad: tc3589x: localize platform data
In-Reply-To: <20150327164744.GA17364@dtor-ws>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <1426776765-18812-2-git-send-email-linus.walleij@linaro.org>
 <20150319163856.GF30732@dtor-ws> <20150327164744.GA17364@dtor-ws>
Message-ID: <CACRpkdY+o+uddX-r_oZsmeH6PyjhgUveaUHAV+Wg5tDPHEcxkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 5:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Hmm, just noticed an issue:
>
>> >
>> >     keypad = kzalloc(sizeof(struct tc_keypad), GFP_KERNEL);
>> > +   keypad->board = tc3589x_keypad_of_probe(&pdev->dev);
>> > +   if (IS_ERR(keypad->board)) {
>> > +           dev_err(&pdev->dev, "invalid keypad platform data\n");
>> > +           return PTR_ERR(keypad->board);
>> > +   }
>> > +
>> >     input = input_allocate_device();
>> >     if (!keypad || !input) {
>> >             dev_err(&pdev->dev, "failed to allocate keypad memory\n");
>
> You slid of prasing right in between memory allocation and checking if
> it succeeded, so there is a potential oops and memory leak now.
>
> I want to commit the version of the patch below, holler if you disagree.
> Note that I reverted much of plat -> board renames to keep the patch
> small.

Sorry. The new version looks fine. Reviewed-by.

Yours,
Linus Walleij
