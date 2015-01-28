From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Jan 2015 18:08:16 +0000
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
Message-ID: <20150128180816.GF31752@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 05:58:54PM +0000, Timur Tabi wrote:
> On Wed, Jan 14, 2015 at 9:04 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > From: Al Stone <al.stone@linaro.org>
> >
> > Introduce one early parameters "off" and "force" for "acpi", acpi=off
> > will be the default behavior for ARM64, so introduce acpi=force to
> > enable ACPI on ARM64.
> >
> > Disable ACPI before early parameters parsed, and enable it to pass
> > "acpi=force" if people want use ACPI on ARM64. This ensures DT be
> > the prefer one if ACPI table and DT both are provided at this moment.
> 
> What is the reason to assume that DT is preferred over ACPI?  I would
> have thought that if ACPI is present, then it means we're on an ARM64
> server platform, and therefore it should be used.  It seems silly to
> require acpi=force on every ARM64 server platform.

I'm against requiring acpi=force when *only* ACPI tables are present (I
don't like a command line argument to become firmware-kernel ABI), but
otherwise DT takes precedence (it was the first supported booting method
on arm64 and currently it is more mature and feature-rich than ACPI on
arm64).

-- 
Catalin
