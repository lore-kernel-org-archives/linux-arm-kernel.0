From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 15 May 2016 11:58:43 +0200
Subject: Unclear BSD licensing (headers, MODULE_LICENSE, versions)
In-Reply-To: <20160515024327.GB7799@thunk.org>
References: <CACna6ryZS1Q8=kBMMePAE_A377OReaYJdx8azZBrqG2jG+eMJg@mail.gmail.com>
 <20160515024327.GB7799@thunk.org>
Message-ID: <CACna6rzY4O=mqDsfrCtVxuKnyWrNn+_HBW+jsQn3UnVXAzna7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding linux-doc@ which I probably should use from the beginning]

On 15 May 2016 at 04:43, Theodore Ts'o <tytso@mit.edu> wrote:
> On Sun, May 15, 2016 at 12:44:35AM +0200, Rafa? Mi?ecki wrote:
>>
>> I recently received a hint that it would be nice/expected to have DTS
>> files licensed under BSD. I had no experience with BSD, so I started
>> looking at this and the way kernel parts use it.
>
> There is a lot of sloppiness in some of the driver code.
> Unfortunately, fixing it is something that really has to be done by
> the copyright holder, or whoever submitted the kernel in the first
> place and who has clear knowledge of what the copyright holder had
> intended.
>
> There is also a fairly wide range of seriousness of the various
> defects you've listed.  On one extreme, although it's true that some
> license, such as the ClearBSD license has <Organization> in its
> template, when the original code file you've referenced has in its header:
>
>  * Copyright 2004-2012 Analog Devices Inc.
>  * Licensed under the Clear BSD license.
>
> ....tt's pretty obvious that Organization should be "Analog Devices Inc".
>
> In other cases, it's pretty clear that someone copied the drivers from
> some out-of-tree distribution (e.g., "see kernel-base/COPYING...") and
> where finding the original distribution and then adding the Copyright
> permission statement is a pretty easy thing to do.  (And in case where
> a third party can easily show proof that the intent of the copyright
> holder is clearly expressed, that third party probably is able to
> submit a patch to fix up the source file.

Thanks for your comments. I think I will try to contact authors of
unclear drivers once we get requirements described a bit better.
Hopefully at least some of them will respond.


>> I'm wondering how we could improve this situation. I got 2 main ideas:
>>
>> 1) Extend MODULE_LICENSE
>> We could add new acceptable entries specifying BSD version. We could
>> try to improve checkpatch.pl to look for a full license in a header
>> (it seems to be required as it has to provide <organization>). Maybe
>> we could figure out (with some lawyers?) how to treat sources using
>> "Dual BSD/GPL" mentioning GPL only (without BSD) in their header.
>
> I'm not a fan of this approach.  MODULE_LICENSE puts a hint about the
> copyright license of a module where it can be found by the module
> loader.  This is useful to enforce things like GPL_SYMBOL_EXPORT, but
> I don't think we should try to make MODULE_LICESE to be more than
> that.

OK, if others agree, I'm fine with leaving MODULE_LICENSE as is.


>> 2) Get clear rules on how to write a header
>> If you find extending MODULE_LICENSE a bad idea, maybe we can simply
>> help people write proper headers. Explain the problem, provide
>> examples, maybe add some check in checkpatch.pl.
>
> Adding more text about how to add a proper copyright notice and
> license permission statement to the SubmittingDrivers file seems like
> a good idea.
>
> I doubt we can make checkpatch.pl smart enough to handle this
> situation cleanly.

Thanks, I'll prepare & send patch updating SubmittingDrivers and maybe
some related files (if needed).

However there are some questions I need to ask first:


1) Can we add COPYING-BSD-2-CLAUSE (or similar)?

We already have GPL drivers with headers like:
a) "Licensed under the GNU/GPL. See COPYING for details."
b) "This driver is released to the public under the terms of the GNU
GENERAL PUBLIC LICENSE version 2"

Adding a similar file (e.g. COPYING-BSD-2-CLAUSE) would allow BSD
drivers to reference it as well, e.g.:
"Licensed under the BSD 2-clause. See COPYING-BSD-2-CLAUSE for details."
or similar.
As described earlier, there are some drivers /mentioning/ usage of BSD
license (in a header or with MODULE_LICENSE) without providing its
text at all.


2) How about sharing BSD 3-clause license?

Does it make sense to add anything like COPYING-BSD-3-CLAUSE? Should
we leave <organization> in license text in such file? Or should we
replace it with "author" as some drivers do? How drivers could
reference such file? Would a simple
"Licensed under the BSD 3-clause. See COPYING-BSD-3-CLAUSE for details."
be enough? Or should it be more specific like "With <organization>
being Foo Company"?

Or maybe we shouldn't add anything like COPYING-BSD-3-CLAUSE at all
and just require all drivers to attach whole text of BSD 3-clause
license in a header?

The same questions apply to Clear BSD license which also has
<organization> in its text.

-- 
Rafa?
