From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Nov 2011 13:11:12 +0000
Subject: [PATCH v2] gpio/samsung: Add device tree support for Exynos4
In-Reply-To: <CAJuYYwSfjg04gaJUgNkUzFNgs5d_7PL9nio-1RwrPizyShTxGQ@mail.gmail.com>
References: <1320108227-2693-1-git-send-email-thomas.abraham@linaro.org>
	<4EAFAC42.5080607@gmail.com>
	<CAJuYYwSfjg04gaJUgNkUzFNgs5d_7PL9nio-1RwrPizyShTxGQ@mail.gmail.com>
Message-ID: <20111102131112.GD27100@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 06:35:05PM +0530, Thomas Abraham wrote:
> On 1 November 2011 13:52, Sylwester Nawrocki <snjw23@gmail.com> wrote:

> > It doesn't give as much advantage, and introduces an overhead of doing
> > an additional remapping. However I find current mapping of the DT specifier
> > values to real driver strength slightly confusing.
> > Perhaps unlikely, the future SoCs could have different meaning of the
> > register values.

> The dts file describes the hardware and the drive strength values
> listed above are as per the Exynos4 SoC user manual. I would prefer to
> do it the way you suggested, but that would mean dts is not exactly
> matching the hardware manual.

On the other hand it does mean that the user can directly read the
values - there's nothing that obviously tells the user that the binding
is using datasheet register values rather than the actual driver
strength numbers and given that software is supposed to provide an
abstraction to make things easier it seems reasonably natural to assume
the latter.
