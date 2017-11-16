From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 08:46:08 -0800
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116135650.GQ10515@gate.crashing.org>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
 <20171116130742.wijnukjetoupi4hc@yury-thinkpad>
 <20171116135650.GQ10515@gate.crashing.org>
Message-ID: <20171116164608.GG94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 07:56:50AM -0600, Segher Boessenkool wrote:
> The compiler is fine, the assembler is fine (and the linker has
> nothing to do with it).  Your code is not fine.

Would you care to elaborate? The current code assumes that macros are
visible in other inline assembly blocks, and LLVM developers seem to
feel this isn't correct behavior. This patch fixes the current code so
it works with both assemblers.

Sami
