From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 9 Nov 2017 08:45:42 -0800
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
Message-ID: <20171109164542.GB10540@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 12:25:55PM +0300, Yury Norov wrote:
> The patch below uses trick with undefining mrs_s/msr_s immediately
> after use to solve the problem. It works for both gcc and clang.

Great, looks good to me! I tested the patch with LTO and clang's integrated
assembler seems to be happy with it.

> It has solved many problems you also try to solve, and some patches
> are looking very similar.

I haven't had a closer look at the gcc LTO patches yet, but I am definitely
all for using common code where possible.

Sami 
