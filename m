From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Mar 2016 14:24:39 +0000
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160319171336.6e16eb5a@scratchpost.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160315105802.GN2566@sirena.org.uk>
 <20160319171336.6e16eb5a@scratchpost.org>
Message-ID: <20160321142438.GU2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 19, 2016 at 05:13:36PM +0100, Danny Milosavljevic wrote:
> Hi Mark,

> my question is whether it's possible to group together the left and right channel into one selem, and also if it's possible to reuse volumes then. For example:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.  This is particularly important for large
walls of text like this.

> Is it possible to group them together like this? How?

This is something you'd need to change in alsamixer and the control
naming standards.  None of this stuff is really supposed to be directly
edited by normal users, they should mostly be using a UCM configuration,
so at the minute this is essentially bikeshedding.

> Is it possible to somehow distinguish those in alsamixer? Do we want to?

I think you're looking for something that exports routing to userspace.
Doing that would also help with reducing the faff with naming rules.
Currently nobody is working on that but I think people would be very
happy if someone were to work on it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/f0f61045/attachment-0001.sig>
