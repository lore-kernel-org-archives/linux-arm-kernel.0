From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 14:56:49 -0700
Subject: [PATCH v9 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <D49A3E92-54FD-4275-82F5-DBB476086B03@codeaurora.org>
References: <1382956118-12495-1-git-send-email-acourbot@nvidia.com>
 <1382956118-12495-2-git-send-email-acourbot@nvidia.com>
 <D49A3E92-54FD-4275-82F5-DBB476086B03@codeaurora.org>
Message-ID: <20131028215649.GB10833@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 05:57:04AM -0500, Kumar Gala wrote:
> 
> On Oct 28, 2013, at 5:28 AM, Alexandre Courbot wrote:
> 
> > Trusted Foundations is a TrustZone-based secure monitor for ARM that
> > can be invoked using the same SMC-based API on all supported
> > platforms. This patch adds initial basic support for Trusted
> > Foundations using the ARM firmware API. Current features are limited
> > to the ability to boot secondary processors.
> > 
> > Note: The API followed by Trusted Foundations does *not* follow the SMC
> > calling conventions. It has nothing to do with PSCI neither and is only
> > relevant to devices that use Trusted Foundations (like most Tegra-based
> > retail devices).
> > 
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > Reviewed-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > .../arm/firmware/tl,trusted-foundations.txt        | 20 ++++++
> > .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> > arch/arm/Kconfig                                   |  2 +
> > arch/arm/Makefile                                  |  1 +
> > arch/arm/firmware/Kconfig                          | 28 ++++++++
> > arch/arm/firmware/Makefile                         |  1 +
> > arch/arm/firmware/trusted_foundations.c            | 79 ++++++++++++++++++++++
> > arch/arm/include/asm/trusted_foundations.h         | 67 ++++++++++++++++++
> > 8 files changed, 199 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> > create mode 100644 arch/arm/firmware/Kconfig
> > create mode 100644 arch/arm/firmware/Makefile
> > create mode 100644 arch/arm/firmware/trusted_foundations.c
> > create mode 100644 arch/arm/include/asm/trusted_foundations.h
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> > new file mode 100644
> > index 0000000..2ec75c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
> > @@ -0,0 +1,20 @@
> > +Trusted Foundations
> > +-------------------
> > +
> > +Boards that use the Trusted Foundations secure monitor can signal its
> > +presence by declaring a node compatible with "tl,trusted-foundations"
> > +under the /firmware/ node
> > +
> > +Required properties:
> > +- compatible : "tl,trusted-foundations"
> > +- version-major : major version number of Trusted Foundations firmware
> > +- version-minor: minor version number of Trusted Foundations firmware
> 
> vendor prefix version.

Are you saying he should use tl,version-major tl,version-minor? For bindings
that are already vendor-specific we haven't (on ARM) asked for vendor prefix on
properties. It doesn't mean that we should keep going down that route though,
so I'm just asking for clarification for my own edification. :)


-Olof
