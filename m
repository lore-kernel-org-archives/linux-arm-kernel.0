From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Feb 2017 17:54:29 +0000
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
In-Reply-To: <20170221110730.GF5021@amd>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <20170221110730.GF5021@amd>
Message-ID: <20170221175429.GF8605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 12:07:30PM +0100, Pavel Machek wrote:
> On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
> > Nothing in the PSCI specification requires the SoC to remain powered and
> > to support wake-up sources when suspended using SYSTEM_SUSPEND.
> > If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
> > power to the SoC, the only possibly wake-up sources are thus the ones
> > connected to the PMIC.
> > 
> > Document and add support for an "arm,psci-system-suspend-is-power-down"
> > DT property, so Linux uses a different suspend method when other wake-up
> > sources (e.g. wake on LAN, UART or GPIO) are enabled.
> 
> Should we make PSCI return that information? (At least in next
> specification version?)

Largely, this is somewhat ill-defined, so it's not something that can be
easily (or correctly) described by a limited firmware call interface.

I believe that the correct way to describe this is to describe the
wakeup capabilities on devices. Both ACPI and DT have mechanisms for
that today, though it seems that there is confusion as to precisely how
to use them.

Thanks,
Mark.
