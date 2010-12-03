From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 03 Dec 2010 10:59:07 +0100
Subject: [PATCH 3/4] plat-s5p: Add platform support for MIPI-CSI2 devices
In-Reply-To: <AANLkTikjQkmD-bvtTV=fh-xqMkhsxt67LhAUWuCv5mU3@mail.gmail.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-4-git-send-email-s.nawrocki@samsung.com>
	<20101202171538.GB30933@pulham.picochip.com>
	<4CF7D9E6.5000409@samsung.com>
	<AANLkTikjQkmD-bvtTV=fh-xqMkhsxt67LhAUWuCv5mU3@mail.gmail.com>
Message-ID: <000301cb92d0$bd2a7400$377f5c00$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, December 03, 2010 2:37 AM Jassi Brar wrote:

> On Fri, Dec 3, 2010 at 2:39 AM, Sylwester Nawrocki

<snip>

> > I agree explicit indices are not really needed. I just followed the style of
> > all other resource definitions already there.
> > I am not quite sure what is the preference of the maintainer, I guess they want
> > all devices to follow same style for consistence.
> 
> And that style has its origin because explicit indices are as because
> they stress the fact that
> drivers expect  a particular resource at a particular index (when we
> have more than 1
> resource of a type).
> IMO we should use some macro shared between platform devices and their drivers.
> Something like -
> static struct resource s5p_csis_resource[] = {
>        [PA_CSIS] = {
>                .start = S5P_PA_CSIS0,
>                .end   = S5P_PA_CSIS0 + SZ_4K - 1,
>                .flags = IORESOURCE_MEM,
>        },
>        [IRQ_CSIS] = {
>                .start = IRQ_MIPICSI0,
>                .end   = IRQ_MIPICSI0,
>                .flags = IORESOURCE_IRQ,
>        }
> };

This looks like a huge over-engineering for me, especially for the simple device
that has only one register area and interrupt.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
