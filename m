From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Nov 2017 11:47:23 +0000
Subject: [PATCH v2 09/18] arm64: explicitly pass
 --no-fix-cortex-a53-843419 to GNU gold
In-Reply-To: <20171115213428.22559-10-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-10-samitolvanen@google.com>
Message-ID: <20171116114722.GD9361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:34:19PM -0800, Sami Tolvanen wrote:
> Some versions of GNU gold are known to produce broken code with
> --fix-cortex-a53-843419 as explained in this bug:
> 
>   https://sourceware.org/bugzilla/show_bug.cgi?id=21491
> 
> If ARM64_ERRATUM_843419 is disabled and we're using GNU gold, pass
> --no-fix-cortex-a53-843419 to the linker to ensure the erratum fix is not
> used even if the linker is configured to enable it by default.

But if ARM64_ERRATUM_843419 is enabled, we'll go ahead and generate broken
code?

Will
