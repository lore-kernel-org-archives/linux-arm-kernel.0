From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 18:44:10 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140728162340.GA32359@quad.lixom.net>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <53D60D11.8050205@linaro.org>
 <20140728162340.GA32359@quad.lixom.net>
Message-ID: <20140728174410.GD17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 09:23:40AM -0700, Olof Johansson wrote:
> On Mon, Jul 28, 2014 at 09:42:57AM +0100, Graeme Gregory wrote:

> > >>+On no account should a Device Tree attempt to be replicated in ASL using such
> > >>+constructs as Name(KEY0, "Value1") type constructs. Additional driver specific
> > >>+data should be passed in the appropriate _DSM (ACPI Section 9.14.1) method or
> > >>+_DSD (ACPI Section 6.2.5). This data should be rare and not OS specific.

...

> > >I see these two sentences as contradictory, given that the _DSD doc
> > >worst case turn into quite a mess.

> > >Given that ACPI can present completely different data based on what OS
> > >is running, it's quite common to indeed have OS specific data in
> > >there. How does that relate to this document and these practices?

> > OS specific data has traditionally not worked out well for ACPI, I
> > would like to "persuade" people not to use it on ARM.

> It hasn't? I think Microsoft disagrees. It's also how vendors have been able to
> present an older machine description to keep their newer hardware compatible
> with older software, isn't it? How do you expect to handle that if you can
> only present one table? It's the same challenge that DT has.

It seems sensible to recommend against using OS specifics if possible if
only from the point of view of improving the robustness of the system -
the less paths there are to test in the BIOS the more likely it is that
the active path is one that's been well tested.  It's legal in the spec
and you can do it but encouraging people not to do it will hopefully
make life easier down the line.  Similarly encouraging people to put as
little as possible in there should reduce the opportunities they have to
get things wrong.

The best use case for OS testing is to enable a non-default workaround
for older versions of the OS but in the case of Linux that's a bit
tricky since we don't have clear versions to test against - even with
the kernel version number it's never clear if it's been patched by a
distro or something.  Windows is a much more fixed target here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/2f24bc2a/attachment.sig>
