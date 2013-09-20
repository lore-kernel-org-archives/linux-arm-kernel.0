From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:49:27 +0200
Subject: [PATCH 01/26] ARM: nomadik: move mtu setup to clocksource init
In-Reply-To: <1379526839-14798-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZqm=3oed979Jyg7n+8KwW_-2AGv3OzJBTPN20ZH=Vc3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 7:53 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> MTU timer initialization is stuffed into .init_time callback, while
> cpu8815_timer_init_of again maps addresses from the same device node.
> Therefore, this patch moves mtu setup from to clocksource init.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Another happy Nomadik user? Or are you just compile testing
this?

Actually, this is superceded and collides with this pending fix:
http://marc.info/?l=linux-arm-kernel&m=137910161418706&w=2

We should wait for that to hit mainline and then see what we want
to do with this.

Yours,
Linus Walleij
