From: zonque@gmail.com (Daniel Mack)
Date: Wed, 18 Dec 2013 13:23:26 +0100
Subject: [PATCH V2 2/8] string: fix strncmp function
In-Reply-To: <20131218121551.GH4360@n2100.arm.linux.org.uk>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
 <1387368551-18958-3-git-send-email-p.wilczek@samsung.com>
 <20131218121551.GH4360@n2100.arm.linux.org.uk>
Message-ID: <52B193BE.1080206@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2013 01:15 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 18, 2013 at 01:09:05PM +0100, Piotr Wilczek wrote:
>> Now function returns the number of characters that differ in the
>> compared strings.
> 
> I think this is a mistake.  You're defining a standard C function in
> a non-standard way.  For strcmp() and strncmp(), the C standard
> requires:
> 
> RETURN VALUE
>        The strcmp() and strncmp() functions return an integer less than, equal
>        to, or greater than zero if s1 (or the first n bytes thereof) is found,
>        respectively, to be less than, to match, or be greater than s2.
> 
> If you implement something different to that, don't call it strcmp() or
> strncmp() but something else, because you're not providing the correct
> functionality, and that will just confuse people and lead to bugs.

True.

> For instance, can you be sure that there aren't any uses of strncmp()
> which already test for less-than-zero etc?

In this case, yes. The code as it stands is very small, and users only
check for the return value of these functions to be 0.

But I wonder whether that patch is needed at all. At least the rest of
this series does not even seem to introduce new call sites of strcmp()
or strncmp() ...


Daniel
