From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 1 Nov 2017 12:09:19 -0700
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
Message-ID: <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 1, 2017 at 12:03 PM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
>
> By default, ndelay is implemented in terms of udelay.

That's very much *NOT* the case.

Yes, there is a *fallback* for when somebody doesn't do ndelay() at
all, but that doesn't make it the default.

It's just a "the architecture didn't implement ndelay at all, we'll
work around it".

So stop this idiocy already. About half of what I've seen in this
thread has been pure garbage.

                       Linus
