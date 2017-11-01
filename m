From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Wed, 1 Nov 2017 20:38:42 +0100
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
Message-ID: <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 20:09, Linus Torvalds wrote:

> On Wed, Nov 1, 2017 at 12:03 PM, Marc Gonzalez wrote:
>
>> By default, ndelay is implemented in terms of udelay.
> 
> That's very much *NOT* the case.
> 
> Yes, there is a *fallback* for when somebody doesn't do ndelay() at
> all, but that doesn't make it the default.
> 
> It's just a "the architecture didn't implement ndelay at all, we'll
> work around it".

Yes, sorry, I wrote "default" when I meant "fallback".
(arm32 currently does not define a specific ndelay implementation.)

> So stop this idiocy already. About half of what I've seen in this
> thread has been pure garbage.

OK, I'll just send my patch, and then crawl back under my rock.

Regards.
