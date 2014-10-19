From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Oct 2014 13:28:24 -0700
Subject: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
In-Reply-To: <20141019201451.GV12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <543EF2B6.1050009@hurleysoftware.com>
 <20141016001801.GQ12379@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
 <20141017134112.GS12379@n2100.arm.linux.org.uk>
 <20141019095555.GU12379@n2100.arm.linux.org.uk>
 <CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com>
 <20141019185118.GA22014@n2100.arm.linux.org.uk>
 <CA+55aFwy1hg25p3amy1xZq58afcaNSgP+uy=UA19BSgoVpARVQ@mail.gmail.com>
 <20141019201451.GV12379@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMiVazGxN01obN5-ePn0cMksqzAb=SAcR49V8R3=bzOgcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 19, 2014 at 1:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Oct 19, 2014 at 01:04:20PM -0700, Linus Torvalds wrote:
>> On Sun, Oct 19, 2014 at 11:51 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> >
>> > Does that work for things like allnoconfig and randconfig?  I guess people
>> > /could/ seed those appropriately, but that seems to be something that Olof
>> > wants to avoid doing.
>>
>> You can force particular config options for those, using something like
>>
>>     export KCONFIG_ALLCONFIG=custom.config
>>
>> and filling the custom config file with the required config setting.
>
> Yes, this is what I meant above by "seed"ing the configurations, and it
> is something I do all the time with my autobuilder here for things like
> allnoconfig where I want to ensure that certain options have specific
> values.
>
> When I talked to Olof about it, he seemed to be against using the
> facility in his autobuilder.  I'm not clear on why that was, but I
> suspect it's because Olof wants to test real allnoconfig builds.
>
> An alternative is we could have a HAVE_GCC_PR58854_FIX preprocessor
> conditional, and pass in KCFLAGS=-DHAVE_GCC_PR58854_FIX to the kernel
> to bypass the check.
>
> Either way, I think we need Olof's input on this to say what he's
> willing to do.

I definitely don't mind adjusting the script, I've got some plans to
add debug info on the builds that I boot as well, so I need to deal
with a few fragments anyway. I haven't had much time to do that just
yet, so this might raise it on the list of priorities a bit.

However, in this particular case I think I'll just upgrade gcc
instead. Last time I tried 4.9, it spewed a lot of new warnings. As
long as they're mostly gone I'll just switch over.

Russell: You might get a few duplicate reports as I try out the new toolchain.


-Olof
