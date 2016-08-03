From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Aug 2016 14:30:41 +0100
Subject: [PATCH] ARM64: dts: bcm: Use a symlink to R-Pi dtsi files from
 arch=arm
In-Reply-To: <CAL_JsqKs+9UxKa=_PZWM-AO8b+MqbxypO_3h6ZGQtYjHcB1Drg@mail.gmail.com>
References: <1470213635-6934-1-git-send-email-ijc@hellion.org.uk>
 <CAL_JsqKs+9UxKa=_PZWM-AO8b+MqbxypO_3h6ZGQtYjHcB1Drg@mail.gmail.com>
Message-ID: <20160803133041.GA12499@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2016 at 08:13:51AM -0500, Rob Herring wrote:
> On Wed, Aug 3, 2016 at 3:40 AM, Ian Campbell <ijc@hellion.org.uk> wrote:
> > The ../../../arm... style cross-references added by commit 9d56c22a7861
> > ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.") do not work in the
> > context of the split device-tree repository[0] (where the directory
> > structure differs). As with commit 8ee57b8182c4 ("ARM64: dts: vexpress: Use
> > a symlink to vexpress-v2m-rs1.dtsi from arch=arm") use symlinks instead.
> >
> > These includes in turn require a skeleton.dtsi to be present, so add one as
> > a real file (with the same contents as arch/arm) rather than a symlink.
> 
> I don't follow why skeleton.dtsi is needed. The 32-bit RPi dts files
> are including it? If so, can we just remove it. We decided
> skeleton.dtsi was a bad idea.

Yup. I don't want to see skeleton.dtsi reappear, and the necessary
fixups to source files are relatively simple.

Ian, see commit 3ebee5a2e141496b ("arm64: dts: kill skeleton.dtsi") for
the rationale, and hints as to what needs to be fixed up (e.g. if empty
memory nodes are required, there should be a comment as to why).

Perhaps this is a good time to attack the remaining 32-bit skeleton.dtsi
users. I'll take another look come -rc1.

Thanks,
Mark.
