From: dianders@google.com (Doug Anderson)
Date: Wed, 23 Apr 2014 15:51:45 -0700
Subject: [PATCH 2/2] arm: use fixmap for text patching when text is RO
In-Reply-To: <CAGXu5jJFRapP6EA_T6fCK1po_4sf=34mpC13t9L0SCo1COB5gQ@mail.gmail.com>
References: <1396646870-29695-1-git-send-email-rabin@rab.in>
 <1396646870-29695-2-git-send-email-rabin@rab.in>
 <CAGXu5jJFRapP6EA_T6fCK1po_4sf=34mpC13t9L0SCo1COB5gQ@mail.gmail.com>
Message-ID: <CAD=FV=U4WxMLyEAgGExc=Q7r9jy=AS3mtxSoi=M+Qgw_e=U-bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kees,

On Wed, Apr 23, 2014 at 2:09 PM, Kees Cook <keescook@chromium.org> wrote:

> I think we can use this for the kgdb case too. Has anyone tried that
> yet? Perhaps implementing text_poke() in terms of patch_map/unmap
> calls would be best? Then the arm-specific kgdb hooks can use that,
> since it does the icache flushing separately.

Yes.  I just tried using these patches and it worked for me.  :)  I
didn't actually implement text_poke(), though.

Atop our 3.8 tree, in case anyone is curious

* https://chromium-review.googlesource.com/196670
* https://chromium-review.googlesource.com/196671
* https://chromium-review.googlesource.com/196672
* https://chromium-review.googlesource.com/196673
* https://chromium-review.googlesource.com/196674

Please include me on the CC list for spins of your patches...

-Doug
