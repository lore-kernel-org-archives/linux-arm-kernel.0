From: danielmicay@gmail.com (Daniel Micay)
Date: Fri, 15 Jul 2016 15:19:23 -0400
Subject: [kernel-hardening] Re: [PATCH v2 02/11] mm: Hardened usercopy
In-Reply-To: <CAGXu5jLiD1xEb=dDuf+_2JVzmkH_6O5-m=p=AVvi7qgQ+SV4UA@mail.gmail.com>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-3-git-send-email-keescook@chromium.org>
 <20160714232019.GA28254@350D>
 <CAGXu5jKzD_rCMNJQU1bB5KDfKTsb+AaidZwe=FAfGMqt_FkfqQ@mail.gmail.com>
 <1468609254.32683.34.camel@gmail.com>
 <CAGXu5jLiD1xEb=dDuf+_2JVzmkH_6O5-m=p=AVvi7qgQ+SV4UA@mail.gmail.com>
Message-ID: <1468610363.32683.42.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'd like it to dump stack and be fatal to the process involved, but
> yeah, I guess BUG() would work. Creating an infrastructure for
> handling security-related Oopses can be done separately from this
> (and
> I'd like to see that added, since it's a nice bit of configurable
> reactivity to possible attacks).

In grsecurity, the oops handling also uses do_group_exit instead of
do_exit but both that change (or at least the option to do it) and the
exploit handling could be done separately from this without actually
needing special treatment for USERCOPY. Could expose is as something
like panic_on_oops=2 as a balance between the existing options.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 851 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/f6cde39b/attachment.sig>
