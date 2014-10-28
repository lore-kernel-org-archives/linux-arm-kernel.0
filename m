From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Oct 2014 09:06:35 -0700
Subject: [PATCH 1/4] pinctrl: rockchip: Set wake_enabled
In-Reply-To: <CACRpkdZO+TuCodDzLZ2evRc0ak+4of38aKNqCiC5cMkm++keHw@mail.gmail.com>
References: <1413847670-12245-1-git-send-email-dianders@chromium.org>
 <CACRpkdZO+TuCodDzLZ2evRc0ak+4of38aKNqCiC5cMkm++keHw@mail.gmail.com>
Message-ID: <CAD=FV=UFRPDtKpgpbnMf4U33C0VVP+BzZRj4rsN_D3OGxJwfzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Tue, Oct 28, 2014 at 8:51 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 21, 2014 at 1:27 AM, Doug Anderson <dianders@chromium.org> wrote:
>
>> The rockchip pinctrl driver uses irq_gc_set_wake() but doesn't setup
>> the .wake_enabled member.  That means that we can never actually use a
>> pin for wakeup.  When "irq_set_irq_wake()" tries to call through it
>> will always get a failure from set_irq_wake_real() and will then set
>> wake_depth to 0.  Assuming you can resume you'll later get an error
>> message about "Unbalanced IRQ x wake disable".
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
> Heiko, are you looking at this patch series? Need you Reviewed-by
> to merge this stuff.

See Heiko's review on the latest version of this series (v2).

https://patchwork.kernel.org/patch/5126811/
https://patchwork.kernel.org/patch/5126941/
https://patchwork.kernel.org/patch/5126971/
https://patchwork.kernel.org/patch/5126801/

-Doug
