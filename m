From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 03 Mar 2016 10:12:55 +0000
Subject: [PATCH] ARM: dts: add "simple-bus" to "arm, amba-bus"
 compatible nodes
In-Reply-To: <CAK7LNAQzkg5F8wUeF+p30jf9CrpNxi7UTNfqXQgybP2XbEKJag@mail.gmail.com>
References: <1456804620-8750-1-git-send-email-yamada.masahiro@socionext.com>
 <20160301114610.GB30602@leverpostej>
 <CAK7LNAQzkg5F8wUeF+p30jf9CrpNxi7UTNfqXQgybP2XbEKJag@mail.gmail.com>
Message-ID: <1456999975.2856.18.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-03-03 at 12:07 +0900, Masahiro Yamada wrote:
[...]
> This patch is derived from Rob Herring' comment
> "BTW, we should also kill off "amba-bus" which is an ambiguous term"
> in the following thread:
> http://lkml.iu.edu/hypermail/linux/kernel/1601.0/01822.html
> 
> 
> So, the plan would be like this:
> 
> [1] Make device trees not depend on "arm,amba-bus"   (this commit)
> [2] New device trees should no longer use "arm,amba-bus" alone.
> [3] Go though some releases until we do not care about the backward
> compatibility

Why would we stop caring about backwards compatibility? If I was a user
of any of the platforms in question and updated my kernel, I wouldn't
expect to have to debug why it was broken, then install a new dtb to fix
it - which may be a tricky thing to do, depending on the firmware used
to boot Linux.

> [4] Drop "arm,amba-bus" from of_default_bus_match_table

-- 
Tixy
