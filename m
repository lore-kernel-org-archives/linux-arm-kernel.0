From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 10:06:45 +0200
Subject: [PATCH/RFC] ARM: shmobile: Disallow PINCTRL without GPIOLIB
In-Reply-To: <21658140.49USZQOU99@avalon>
References: <20130318135818.23765.51686.sendpatchset@w520>
 <7840344.mRAPGty7WD@avalon>
 <CANqRtoR+xVFx6ytvjcHxNcQ3X=avXs49-pR-XCr7ApqOq_WFRQ@mail.gmail.com>
 <21658140.49USZQOU99@avalon>
Message-ID: <CACRpkdZ9fSoQnF-MgRKi4PUhv56+CuraXhuVgUhLyHcoEnBPZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 4:23 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>> About this issue, the fact that selecting PINCTRL without GPIO results
>> in compile error makes me think that something needs slight adjustment
>> in the PFC code.
>
> The above errors come from the pinctrl core (although the PFC driver might not
> compile either in this case). Linus, what's your opinion on this ? Do we want
> to support systems with pinctrl but without gpiolib ?

Yes. It is perfectly legal to have pin controllers that do not correlate
GPIO ranges.

Does commit 2afe8229687ec24cbc07e78449a588bb8b68f858
"pinctrl: core: add dependence of GPIOLIB"
by Haojian fix this issue?

Yours,
Linus Walleij
