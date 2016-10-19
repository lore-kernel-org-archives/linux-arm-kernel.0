From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 19 Oct 2016 08:55:13 -0700
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161019153746.GA4411@x4>
References: <20161017183806.GG5601@arm.com> <20161019153746.GA4411@x4>
Message-ID: <CA+55aFzSi4V9ZYDfxvZNfz1ogngTywW5Q9U_vQq3v83+0wgPrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 8:37 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
>
> This is a gcc bug, see:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=72785

Well, in the meantime we apparently have to live with it. Unless Will
is using some unreleased gcc version that nobody else is using and we
can just ignore it?

I don't think the link-time check is so important that we need to
notice it, and the "____ilog2_NaN()" could just be replaced with "0".

                 Linus
