From: duwe@lst.de (Torsten Duwe)
Date: Fri, 10 Aug 2018 18:00:43 +0200 (CEST)
Subject: [PATCH 0/3] arm64 live patching
Message-ID: <20180810160043.9E45568C76@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

with gcc-8 now being out which includes the patchable-function-entries feature,
I can now propose the live patching framework based on it. The series consists
of 3 parts:

1st: Implement ftrace with regs -- uses gcc-8's nop insertions to patch in
     ftrace calls.

2nd: "Classic" live patching infrastructure, as far as it's needed for backporting.

3rd: An attempt at reliable stack traces for the consistency model. I'm a bit
     uncertain whether the approach is correct.

	Torsten
