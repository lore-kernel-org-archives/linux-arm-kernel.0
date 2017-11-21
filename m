From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Nov 2017 11:15:06 +0000
Subject: [PATCH v2 09/18] arm64: explicitly pass
 --no-fix-cortex-a53-843419 to GNU gold
In-Reply-To: <20171120203549.GB89108@samitolvanen.mtv.corp.google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-10-samitolvanen@google.com>
 <20171116114722.GD9361@arm.com>
 <20171116163549.GD94341@samitolvanen.mtv.corp.google.com>
 <20171120144720.bf27bpuwq4huhkdp@lakrids.cambridge.arm.com>
 <20171120203549.GB89108@samitolvanen.mtv.corp.google.com>
Message-ID: <20171121111506.qmlhtupzyrvfpgjl@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 12:35:49PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 20, 2017 at 02:47:20PM +0000, Mark Rutland wrote:
> > However, we could instead check ld-version, produce a warning, and
> > abort the build in such cases.
> 
> I believe the version number of gold didn't change in binutils 2.28.1,
> where this was fixed, but we could certainly warn about older versions
> of gold.

If that's the case, can we mandate gold version > 2.28.1?

The latest version seems to be 2.29.1, so there's at least one
(hopefully) working release.

That might rule out a few working gold binaries, but it would save on
unwelcome surprises.

Thanks,
Mark.
