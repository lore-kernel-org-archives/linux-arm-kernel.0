From: heechul@illinois.edu (heechul Yun)
Date: Sat, 28 May 2011 06:59:10 -0500
Subject: A page fault causes exiting from WFI mode for all idling cores?
Message-ID: <BANLkTimzoNRS+MynARc3uBz8h6N06FGRQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While I was investigating page fault handling performance on a quad
core Cortex-A9 ARM processor,?I noticed that whenever there is a
page fault, all idling cores?also?awakened---exiting from WFI instruction
on the idle loop?(and go back to WFI again).

Since the page fault generating program is running on a?single core,
it seems unnecessary to wake up?other idling cores (hence saving
power) as well.

Can anyone tell me if this, exiting from WFI on every page fault, is
correct behavior??If so, why?

Heechul
