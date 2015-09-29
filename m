From: robherring2@gmail.com (Rob Herring)
Date: Tue, 29 Sep 2015 12:11:11 -0500
Subject: [PATCH v4 0/9] Making the generic ACPI GSI layer irqdomain aware
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_Jsq+b10aEREipSsrg69=S4gpv-xZWRYS+TVTvhbqdHGATsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The irqdomain code is not entierely ACPI friendly, as it has some
> built-in knowledge of the device-tree. Nothing too harmful, but enough
> to scare the ARM ACPI developpers which end up with their own version
> of the square wheel.
>
> This small patch series adapts the irqdomain code to remove the
> hurdles that prevent the full blown irqdomain subsystem to be used on
> ACPI, creates an interface between the GSI layer and the irqdomain,
> and as an example, convert the ARM GIC ACPI support to use irqdomains
> as originally intended.
>
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure. The
> "convert the GSI information to be DT friendly" is admitedly not very
> pretty, but I see it as a stepping stone towards unifying the two
> structures.

Did I miss v1-v3 or did the DT change just show up? I probably tuned
out with ACPI in the subject.

Needing fake DT nodes for ACPI is just wrong. There's got to be
another, better way.

Rob
