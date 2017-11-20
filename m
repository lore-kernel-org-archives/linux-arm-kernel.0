From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Nov 2017 14:47:20 +0000
Subject: [PATCH v2 09/18] arm64: explicitly pass
 --no-fix-cortex-a53-843419 to GNU gold
In-Reply-To: <20171116163549.GD94341@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-10-samitolvanen@google.com>
 <20171116114722.GD9361@arm.com>
 <20171116163549.GD94341@samitolvanen.mtv.corp.google.com>
Message-ID: <20171120144720.bf27bpuwq4huhkdp@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 08:35:49AM -0800, Sami Tolvanen wrote:
> On Thu, Nov 16, 2017 at 11:47:23AM +0000, Will Deacon wrote:
> > But if ARM64_ERRATUM_843419 is enabled, we'll go ahead and generate
> > broken code?
> 
> This bug has been fixed in all current versions of GNU gold, but of
> course, if someone is using a broken linker, it will generate broken
> code. We can't do anything about that in the kernel.

However, we could instead check ld-version, produce a warning, and abort
the build in such cases.

Which would be better than silently producing a kernel that won't work
correctly.

Thanks,
Mark.
