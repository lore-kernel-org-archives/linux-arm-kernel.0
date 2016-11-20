From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 20 Nov 2016 03:47:34 +0100
Subject: commit 4dd1837d7589f468ed109556513f476e7a7f9121 breaks build
Message-ID: <58310EC6.4020402@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this is a resend of my initial mail, see below, to Al Viro (which sadly
was ignored).

It's rc5 now, and this issue still remains. Putting some more lists on
the Cc now.

Reverting the commit still works for me.


With best wishes,
Tobias

----------------


Hello Al,

compiled a kernel on armv7 with torvalds/master today and getting some
errors during the modpost phase.

> ERROR: "_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_test_and_set_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_clear_bit" [sound/usb/snd-usbmidi-lib.ko] undefined!
> ERROR: "_test_and_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_test_and_set_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_clear_bit" [sound/usb/snd-usb-audio.ko] undefined!
> ERROR: "_test_and_clear_bit" [sound/core/seq/snd-seq.ko] undefined!
<snip>

It seems like the commit 'arm: move exports to definitions' introduces
this issue.

I quickly went over the commit and I noticed that while it removes the
EXPORT_SYMBOL()s for the bitops from armksyms.c, it doesn't move them
anywhere.

Maybe you can take a look at this?

With best wishes,
Tobias
