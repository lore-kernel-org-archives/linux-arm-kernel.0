From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jan 2012 08:33:54 +0100
Subject: [PATCH 2/2] mach-sa1100: modernize and cleanup timer code
In-Reply-To: <20120112161034.GE2645@Boggieman>
References: <1325672513-16725-1-git-send-email-linus.walleij@linaro.org>
 <20120112161034.GE2645@Boggieman>
Message-ID: <CACRpkdYZaxfArU3_i3RuhxT1-wMM80gn6pnZG_mMwg=Ba-oRgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 5:10 PM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:

> Urs?kta f?rseningen, fick n?got minne kring att cpu klockningen inte fungerade korrekt
> om man inte satte direkt systemklock v?rde. Var n?got som pratade med russell om
> f?r n?got ?r sedan.

Menar du detta:
MIN_OSCR_DELTA * 2

S? ?r det ju med i den nya koden oxo, det ?r ingen semantisk skillnad
s? vitt jag kan se...

Det enda som egentligen ?ndras ?r att minimum lapse mellan tv? events
(mult+shift) ber?knas av clockevent core.

Linus
