From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 3 Mar 2016 14:23:29 -0600
Subject: [PATCH] ARM: dts: add "simple-bus" to "arm,
 amba-bus" compatible nodes
In-Reply-To: <1456999975.2856.18.camel@linaro.org>
References: <1456804620-8750-1-git-send-email-yamada.masahiro@socionext.com>
 <20160301114610.GB30602@leverpostej>
 <CAK7LNAQzkg5F8wUeF+p30jf9CrpNxi7UTNfqXQgybP2XbEKJag@mail.gmail.com>
 <1456999975.2856.18.camel@linaro.org>
Message-ID: <CAL_JsqLBNo2YuJGqBo1DaYgzV7=WuX-0BPutoW3f3U1k0wX3_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 4:12 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> On Thu, 2016-03-03 at 12:07 +0900, Masahiro Yamada wrote:
> [...]
>> This patch is derived from Rob Herring' comment
>> "BTW, we should also kill off "amba-bus" which is an ambiguous term"
>> in the following thread:
>> http://lkml.iu.edu/hypermail/linux/kernel/1601.0/01822.html
>>
>>
>> So, the plan would be like this:
>>
>> [1] Make device trees not depend on "arm,amba-bus"   (this commit)
>> [2] New device trees should no longer use "arm,amba-bus" alone.
>> [3] Go though some releases until we do not care about the backward
>> compatibility
>
> Why would we stop caring about backwards compatibility? If I was a user
> of any of the platforms in question and updated my kernel, I wouldn't
> expect to have to debug why it was broken, then install a new dtb to fix
> it - which may be a tricky thing to do, depending on the firmware used
> to boot Linux.

If no one notices, then there is no ABI. Things break all the time
when nobody cares. It will be more than a few releases for sure. We
may never get to step 3, but we should do step 1 so people stop
copy-n-pasting this in step 2.

Rob
