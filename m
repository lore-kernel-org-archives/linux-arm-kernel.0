From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Mar 2016 11:49:39 +0100
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20160312085222.226d89bf@scratchpost.org>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather> <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
Message-ID: <20160314104939.GL8418@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2016 at 08:52:22AM +0100, Danny Milosavljevic wrote:
> Hi,
> 
> does anyone know the answer to the questions below?
> 
> > The other direction (making two controls which both do the same and update 
> > each other's value) doesn't seem to be easily available. 
> 
> > Should I write a _put handler that does it manually?
> 
> > (Or should that be handled by alsa-lib mixer modules instead?)
> 
> > Is it possible to merge the "Left Mixer" control and respective 
> > "Right Mixer" control into one selem in alsamixer?
> > 
> > Because alsamixer actually has support for one-sided muting.

Mark, do you know how to do it?

IIRC, in order to have shared controls, you just needed to share the
controls structure.

> If that's unknown, I can post v9 without doing the grouping-together
> of mixer controls and we can use it like that - I don't want the
> patch to stall indefinitely on mere usability issues...

Unfortunately, that is exposed to the user-space. Once it's in, you
cannot change it / fix it anymore.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160314/0a31e144/attachment.sig>
