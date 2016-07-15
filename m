From: danielmicay@gmail.com (Daniel Micay)
Date: Fri, 15 Jul 2016 15:00:54 -0400
Subject: [kernel-hardening] Re: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
 <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
Message-ID: <1468609254.32683.34.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This could be a BUG, but I'd rather not panic the entire kernel.

It seems unlikely that it will panic without panic_on_oops and that's
an explicit opt-in to taking down the system on kernel logic errors
exactly like this. In grsecurity, it calls the kernel exploit handling
logic (panic if root, otherwise kill all process of that user and ban
them until reboot) but that same logic is also called for BUG via oops
handling so there's only really a distinction with panic_on_oops=1.

Does it make sense to be less fatal for a fatal assertion that's more
likely to be security-related? Maybe you're worried about having some
false positives for the whitelisting portion, but I don't think those
will lurk around very long with the way this works.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 851 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/05e8ad54/attachment.sig>
