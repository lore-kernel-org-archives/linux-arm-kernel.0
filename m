From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 12:50:22 +0100
Subject: [PATCH V2 2/8] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <CAAgF-BerOfvhPJemVf0HBK5L4edw7pgm9bgwKGL+XSMpoaR3vw@mail.gmail.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-3-git-send-email-padma.v@samsung.com>
 <20130726145319.GI9858@sirena.org.uk>
 <CAAgF-BerOfvhPJemVf0HBK5L4edw7pgm9bgwKGL+XSMpoaR3vw@mail.gmail.com>
Message-ID: <20130727115022.GE9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 06:38:02AM +0530, Padma Venkat wrote:
> On Fri, Jul 26, 2013 at 8:23 PM, Mark Brown <broonie@kernel.org> wrote:

> > As Russell indicated you should really keep the old name around, though
> > marking them as deprecated is OK.  However I'm not sure anyone will have
> > deployed this so I'm not sure how much it matters - every downstream
> > kernel I've seen was still using board files anyway.

> This is there only on exynos5250.dtsi, so changing this file alone is
> enough. patch3 in
> this series have the same.

The idea with DT is that you can bake the DT into a board firmware and
then upgrade the kernel without upgrading the DT.

> Having only the version info is confusing. When I posted my previous version of
> patches I was clear which version introduced in which platform and
> again if I come
> back today and see I again had to search each SoC datasheet. So I think this
> patch now clearly explains what new support introduced in which
> version of IP and which
> SoC platform.

Like I keep saying the problem we've always had is that there's never
been a 1:1 mapping between SoCs and IIS IPs, and of course nobody can
get the documentation on the older SoCs outside of Samsung so...  If it
were a linear march forward in terms of IP it'd be a lot easier :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/ae143062/attachment.sig>
