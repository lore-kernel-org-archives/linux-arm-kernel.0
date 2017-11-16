From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 08:17:31 -0800
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171116115810.GH9361@arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-19-samitolvanen@google.com>
 <20171116115810.GH9361@arm.com>
Message-ID: <20171116161731.GA94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:58:11AM +0000, Will Deacon wrote:
> I'll be honest with you: I'm absolutely terrified about enabling this.

That's understandable, I wouldn't want to enable this by default
quite yet either. This patch doesn't enable LTO for arm64, just makes
it possible to enable the feature. I'm perfectly fine with marking
CONFIG_LTO_CLANG experimental if it makes people more comfortable.

> How much testing has this seen?

I've been running clang LTO kernels for a few months on a Pixel 2 device
without any issues. This is on a 4.4 kernel though.

> Right now, the C standard isn't on our side here and we're relying on
> the compiler not doing this kind of thing. Can we continue to rely on
> that in the face of LTO?

I'll have to check with our LLVM experts, but I have not run into these
issues with current compiler versions. Looking at Andi's old patches,
looks like gcc might be more aggressive in reordering things with LTO
than clang.

Sami
