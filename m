From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 3 Nov 2016 15:43:37 +0000
Subject: [RFC PATCH 0/3] ARM64: meson-gxbb: Add support for system suspend
In-Reply-To: <20161103152545.GB25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <20161103152545.GB25852@remoulade>
Message-ID: <20161103154336.GE25852@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Urrgh, I accidentally sent this when trying to save this to my drafts folder;
sorry for the half-finished reply.

On Thu, Nov 03, 2016 at 03:25:46PM +0000, Mark Rutland wrote:
> On Thu, Nov 03, 2016 at 03:29:22PM +0100, Neil Armstrong wrote:
> > Thie patchset is a very experiment patchset to support the System Suspend
> > feature of the Amlogic Meson GX SoCs.
> > 
> > These SoCs implements system suspend using a non-standard PSCI CPU_SUSPEND
> > parameter to enter system suspend.

> > Note that this RFC is here to seek a better way to handle these platform
> > specific features.

One of the reasons that we want PSCI is that it is a standard interface across
platforms. Generally, we do not want platform-specific interfaces.

In this case, PSCI 1.0+ has SYSTEM_SUSPEND for this purpose.

If PSCI is lacking functionality that vendors want, they should speak to ARM
w.r.t. the PSCI specification -- it can be extended with new functionality as
has already happened with PSCI 0.2 and PSCI 1.0.

Thanks,
Mark.
