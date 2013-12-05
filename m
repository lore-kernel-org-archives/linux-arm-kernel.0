From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 13:24:41 +0000
Subject: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
In-Reply-To: <CAL_JsqKF-_GCRR1d5Hs0F6pCMfLxUYkXAAp9hY7Ywuu1C+aZ0A@mail.gmail.com>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org>
 <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org>
 <CAL_JsqKF-_GCRR1d5Hs0F6pCMfLxUYkXAAp9hY7Ywuu1C+aZ0A@mail.gmail.com>
Message-ID: <20131205132441.GR29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 09:47:49AM -0600, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> > +#ifndef CONFIG_ACPI
> >                 set_cpu_present(cpu, true);
> > +#endif

> Should this be moved to DT cpu topology related code?

Part of the trick there being that there isn't any CPU topology code for
ARMv8 in mainline yet, DT or otherwise - I'm working with some patches
for doing that with DT which I'm hoping to get out soon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/709c050f/attachment.sig>
