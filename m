From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 15:21:40 +0000
Subject: [PATCH v2 00/18] Add support for clang LTO
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171120152139.mfqthlbneeeiythr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wed, Nov 15, 2017 at 01:34:10PM -0800, Sami Tolvanen wrote:
> This series adds build system support for compiling the kernel with clang
> Link Time Optimization (LTO), using GNU gold with the LLVMgold plug-in
> for linking. 

As a high-level comment, this path series is rather confusing for
maintainers, since it's a mixture of basic support, workarounds, and a
new feature, and the commit messages aren't that helpful for those of us
unfamiliar with clang.

It would be *very* helpful if this could be split into a few smaller
patch series that built atop of each other.

Would it be possible to split this into:

(1) (basic) arm64 clang support
(2) gold support (no LTO)
(3) LTO support

... with any necessary workarounds added as-required to the relevant
series?

I think (1) is just the clang-version, -mno-implicit-float, and KVM
patches, and that might stand a chance of getting in soon. IIUC that
fixes the outstanding issues with basic clang support, and would give us
all a common baseline for review, testing, and future debugging.

Thanks,
Mark.
