From: carlo@caione.org (Carlo Caione)
Date: Sun, 8 Mar 2015 12:07:02 +0100
Subject: [PATCH 1/2] pinctrl: Add support for Meson8b
In-Reply-To: <CAOQ7t2Yb2qP_R=exsUWet71uy9vGbfpR-Y+fyr5hE273ipSW0w@mail.gmail.com>
References: <1425657076-6709-1-git-send-email-carlo@caione.org>
 <1425657076-6709-2-git-send-email-carlo@caione.org>
 <20150308084635.GA21781@gmail.com>
 <CAOQ7t2Yb2qP_R=exsUWet71uy9vGbfpR-Y+fyr5hE273ipSW0w@mail.gmail.com>
Message-ID: <CAOQ7t2aG2Gpt4qUaH-72PrHC3-fMGBKA46wQGqZp5dB3GGhjQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 11:43 AM, Carlo Caione <carlo@caione.org> wrote:
> On Sun, Mar 8, 2015 at 9:46 AM, Beniamino Galvani <b.galvani@gmail.com> wrote:
>> I'm not very familiar with the inner mechanisms of the pinctrl
>> subsystem, but I guess that holes in the numbering of pins wouldn't be
>> a problem and thus we can skip the numbers associated to non-existent
>> pins (i.e. GPIOX_11 -> 11, GPIOX_16 -> 16). Pinctrl experts please
>> correct me if I'm wrong :)
>
> Linus, any thought on that?
> The only problem I see is that since the BANK macro works with 'first'
> and 'last' without considering holes, we will be mapping GPIOs that do
> not actually exist in our SoC.

On a second thought this is not correct since 'first' and 'last' are
only used for boundary checking and to compute the bit offset inside
the mux register.

-- 
Carlo Caione
