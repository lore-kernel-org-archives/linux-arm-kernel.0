From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 18 Dec 2013 13:50:10 +0100
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <20131218121551.GH4360@n2100.arm.linux.org.uk>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
 <20131218121551.GH4360@n2100.arm.linux.org.uk>
Message-ID: <000601cefbef$b0795420$116bfc60$%wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Wednesday, December 18, 2013 1:16 PM
> To: Piotr Wilczek
> Cc: devicetree-discuss at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org; Kyungmin Park; Nicolas Pitre; Jason Cooper;
> Daniel Mack
> Subject: Re: [PATCH V2 2/8] string: fix strncmp function
> 
> On Wed, Dec 18, 2013 at 01:09:05PM +0100, Piotr Wilczek wrote:
> > Now function returns the number of characters that differ in the
> > compared strings.
> 
> I think this is a mistake.  You're defining a standard C function in a
> non-standard way.  For strcmp() and strncmp(), the C standard
> requires:
> 
> RETURN VALUE
>        The strcmp() and strncmp() functions return an integer less
> than, equal
>        to, or greater than zero if s1 (or the first n bytes thereof) is
> found,
>        respectively, to be less than, to match, or be greater than s2.
> 
> If you implement something different to that, don't call it strcmp() or
> strncmp() but something else, because you're not providing the correct
> functionality, and that will just confuse people and lead to bugs.
Right, I will copy it from kernel.

> 
> For instance, can you be sure that there aren't any uses of strncmp()
> which already test for less-than-zero etc?
There aren't, but can be in future.

Thank you.
Piotr
