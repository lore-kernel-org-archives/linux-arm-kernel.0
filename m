From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 23 Feb 2010 15:32:19 +0100
Subject: sleeping clk_[enable,disable]?
Message-ID: <63386a3d1002230632v4c98c79dg4512684f76008a7d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A question here:

If you have a clocking hardware that would actually require
clk_[enable,disable] to
sleep in order to ascertain that the clock is actually in the
requested state when
you return from these functions, what can you do?

I could think of several solutions, like:

* Actually let clk_[enable,disable] sleep, make sure all drivers only calls them
  in thread context.

* Impose a state in the clk so it can be "in transition", then an
additional function
  clk_is_stable() which will also have to be added to most drivers but had the
  advantage of not violating the defined clk_[enable,disable] API.

* Throw in udelay():s after the clk_[enable,disable] calls, with some values
  that are unfortunately then spread out in the drivers instead of in the
  clk implementation.

Any ideas?

Linus Walleij
