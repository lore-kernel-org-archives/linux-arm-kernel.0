From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 13:58:42 +0000
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <20141106132828.GP4042@n2100.arm.linux.org.uk>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <1847682.hInUtg9rQz@wuerfel>
 <CAKv+Gu_4X0RNbgJ+BCb9+ccgTKBjcwb9L4aDUY6fFMa0R3PX-w@mail.gmail.com>
 <2567100.Zj7YMcXpZG@wuerfel>
 <CAKv+Gu-0jenous5sLPp+QJa3qRk-RiBgG1vVYP_RmVw0uXaysw@mail.gmail.com>
 <20141106114919.GL26297@ulmo>
 <20141106132828.GP4042@n2100.arm.linux.org.uk>
Message-ID: <20141106135842.GK8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 01:28:28PM +0000, Russell King - ARM Linux wrote:

> For the n'th time, what we know is:

> - gcc 4.9 bare metal seems to define __SIZE_TYPE__ to be unsigned int.
> - gcc 4.9's stddef.h typedef's size_t to __SIZE_TYPE__.
> - therefore, size_t is typedef'd from unsigned int.
> - the kernel typedefs __kernel_size_t from unsigned int.
> - the kernel typedefs size_t from __kernel_size_t.

> So, in theory, size_t in the kernel is unsigned int too.  However, GCC 4.9
> issues loads of complains when %zu or %zd is used with a size_t variable
> in the kernel.

> The question that we've been trying to work out is... why is this?  Right
> now, it seems no one has an answer for this question.  We don't know
> whether it's a compiler bug or not - and Arnd has explained why not.

Isn't this GCC tracking the literal use of size_t in addition to the
actual definition and warning based on that information for the size_t
specific formatting.  Seems weird that it'd only affect a freestanding
build though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/8d8167a2/attachment.sig>
