From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2012 21:09:42 +0300
Subject: [PATCH RESEND] ARM: pxa27x_keypad: clear pending interrupts on
 keypad config
In-Reply-To: <87vcduwkfa.fsf@free.fr>
References: <1351439163-9575-1-git-send-email-anarsoul@gmail.com>
 <87vcduwkfa.fsf@free.fr>
Message-ID: <CA+E=qVeETyX+jY+uKS5HAOymGOnF7x+sKGnmrQ0J=3CbnfVTNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 8:55 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Vasily Khoruzhick <anarsoul@gmail.com> writes:
>
>> Bootloader can leave interrupt bit pending, and it confuses driver.
> OK, looks good to me.
> One question though, just to make sure everything is covered :
>   Suppose that the resume is the consequence of keypad press. If anybody relied
>   previously on "reading the keypad" to know which key was pressed to wakeup the
>   SoC, is it still working after your patch ?

Hi Robert,

Code from git master will not call pxa27x_keypad_config on resume if
device can cause wakeup,
so everything is OK (however it's another issue for pxa27x, because
device is not resuming correctly)

> And I suppose you can't "convince" your bootloader to behave correctly, can you ?

It behaves correctly, it just can't handle last keypress (because it's
booting Linux).
Even if it would be possible to fix this issue in bootloader it's
always nice to keep driver
failure-proof, so it does not fail even if bootloader left something
in non-consistent state.

Regards
Vasily
