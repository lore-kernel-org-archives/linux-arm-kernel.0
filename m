From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 08:35:49 -0800
Subject: [PATCH v2 09/18] arm64: explicitly pass
 --no-fix-cortex-a53-843419 to GNU gold
In-Reply-To: <20171116114722.GD9361@arm.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-10-samitolvanen@google.com>
 <20171116114722.GD9361@arm.com>
Message-ID: <20171116163549.GD94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:47:23AM +0000, Will Deacon wrote:
> But if ARM64_ERRATUM_843419 is enabled, we'll go ahead and generate
> broken code?

This bug has been fixed in all current versions of GNU gold, but of
course, if someone is using a broken linker, it will generate broken
code. We can't do anything about that in the kernel.

The reason for this patch is that the linker can be configured to
enable the erratum fix by default, and we must explicitly disable it
if we don't want the fix, whether it's because of a broken linker, or
in our case, because of issues with kernel modules.

Sami
