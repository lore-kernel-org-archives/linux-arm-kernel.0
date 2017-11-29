From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 29 Nov 2017 15:30:08 -0800
Subject: [v2,12/18] kbuild: add support for clang LTO
In-Reply-To: <20171121110152.23fb751a@roar.ozlabs.ibm.com>
References: <20171115213428.22559-13-samitolvanen@google.com>
 <20171118132139.58ac5e4c@roar.ozlabs.ibm.com>
 <20171120202152.GA89108@samitolvanen.mtv.corp.google.com>
 <20171121110152.23fb751a@roar.ozlabs.ibm.com>
Message-ID: <20171129233008.GB138088@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 11:01:52AM +1000, Nicholas Piggin wrote:
> I just wonder are you doing this because there is some worthwhile
> performance gain? Or to enable more testing and development of LTO?
> Any clues for why a user would want to enable it.

I'm primarily interested in CFI, which with clang requires LTO; not
for the optimizations, but for source visibility. We do expect to see
performance improvements with LTO though, especially if combined with
PGO.

> Thanks, if you could. Possibly file a request with LLVMgold too, it
> seems to be that toolchain support for archives is quite strong, so it
> will be good to keep pushing for that.

It turns out LLVMgold is fine with mixed IR/object archives, but we need
to use llvm-ar to generate symbol tables for them, and there are some
compatibility issues with objdump that I had to work around. I'll send
v3 for review once I receive some feedback for the clang/gold patches we
need first.

Sami
