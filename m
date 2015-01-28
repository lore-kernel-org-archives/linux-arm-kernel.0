From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Jan 2015 18:14:53 +0000
Subject: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
In-Reply-To: <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com>
 <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com>
Message-ID: <20150128181453.GG31752@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 06:08:24PM +0000, Timur Tabi wrote:
> On Wed, Jan 28, 2015 at 11:58 AM, Timur Tabi <timur@codeaurora.org> wrote:
> > What is the reason to assume that DT is preferred over ACPI?  I would
> > have thought that if ACPI is present, then it means we're on an ARM64
> > server platform, and therefore it should be used.  It seems silly to
> > require acpi=force on every ARM64 server platform.
> 
> So it looks like there's a whole conversation about this already in
> this thread that I didn't notice.  However, reading through all of it,
> I still don't understand sure why the presence of ACPI tables is
> insufficient to enable ACPI.  

Because ACPI on arm64 is still experimental, no matter how many people
claim that it is production ready in their private setups.

> In what situation would we want to ignore ACPI tables that are
> present?

When DT tables are also present (and for the first platforms, that's
highly recommended, though not easily enforceable at the kernel level).

-- 
Catalin
