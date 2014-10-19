From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 19 Oct 2014 13:04:20 -0700
Subject: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
In-Reply-To: <20141019185118.GA22014@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <543EF2B6.1050009@hurleysoftware.com>
 <20141016001801.GQ12379@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
 <20141017134112.GS12379@n2100.arm.linux.org.uk>
 <20141019095555.GU12379@n2100.arm.linux.org.uk>
 <CA+55aFw_N=E9O-7VknWTzjNgYG-tB-8736diA1r7K=50b+0czQ@mail.gmail.com>
 <20141019185118.GA22014@n2100.arm.linux.org.uk>
Message-ID: <CA+55aFwy1hg25p3amy1xZq58afcaNSgP+uy=UA19BSgoVpARVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 19, 2014 at 11:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> Does that work for things like allnoconfig and randconfig?  I guess people
> /could/ seed those appropriately, but that seems to be something that Olof
> wants to avoid doing.

You can force particular config options for those, using something like

    export KCONFIG_ALLCONFIG=custom.config

and filling the custom config file with the required config setting.

So the downside is that you do need to have this custom support to
seed particular things, but yes, it's doable, and it only requires a
one-time setup with an environment variable, so it doesn't need
changes to the actual testing infrastructure.

                   Linus
