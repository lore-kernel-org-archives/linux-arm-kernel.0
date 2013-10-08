From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Oct 2013 13:55:16 +0200
Subject: [PATCH 3/6] pinctrl: single: Prepare for supporting SoC specific
 features
In-Reply-To: <20131007173531.GX8949@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054218.8941.19273.stgit@localhost>
 <20131007173531.GX8949@atomide.com>
Message-ID: <CACRpkdbx+vJEqz3KQ0EHGt0axRB4JeJh3FF4e+7snbR0HoqKRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 7:35 PM, Tony Lindgren <tony@atomide.com> wrote:

> Hi Linus W,
>
> Any comments on the pinctrl patches 3 - 5 in this series?

I have no problems with this patch #3, as it is just changing syntax,
not semantics.

The problems start with patch #4.

I am tormented with mixed feelings about this, because from one point of
view I feel it is breaking the promise of pinctrl-single being a
driver for platforms
where a pin is controlled by a *single* register.

If this was pinctrl-foo.c I would not have been so much bothered,
but now it is something that was supposed to be self-contained and
simple, pertaining to a single register, starting to look like something
else.

This is a bit like: "oh yeah just one register controls the pins, but under
some circumstances I also want to mess with this register over here,
and then this register over there ..." etc.

I'd like Haojian to ACK this to proceed since he's also using this driver
now. Then I feel better on continuing down this road ...

Then I have a lesser comment on patch #4 since it makes it possible
for this pin controller to support wake-up interrupt, as I don't see how
this plays out with front-end GPIO controllers, but let's discuss that
in the context of that patch.

Yours,
Linus Walleij
