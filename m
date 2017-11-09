From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 9 Nov 2017 08:50:09 -0800
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171109000222.GC8522@tassilo.jf.intel.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
 <20171109000222.GC8522@tassilo.jf.intel.com>
Message-ID: <20171109165009.GC10540@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 04:02:22PM -0800, Andi Kleen wrote:
> There's also older patches to enable single-pass-linking for kallsyms,
> which is extremly useful for LTO build performance.

Excellent, can you point me to the patch in question?

I worked around the build performance problem by reusing vmlinux.o for
kallsyms instead of linking all bitcode again in each step. I'm not sure
if this is feasible with gcc.

Sami
