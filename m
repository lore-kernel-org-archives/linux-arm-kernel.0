From: broonie@kernel.org (Mark Brown)
Date: Thu, 23 Mar 2017 11:02:49 +0000
Subject: next-20170323 build: 2 failures 4 warnings (next-20170323)
In-Reply-To: <E1cqxc1-0004Cs-Lx@optimist>
References: <E1cqxc1-0004Cs-Lx@optimist>
Message-ID: <20170323110249.3tf3tjo6c2y5qbkh@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 07:56:49AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 allmodconfig and defconfig due to:

> 	arm64-allmodconfig
> 	arm64-defconfig
> ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
> ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
> ERROR: Input tree has errors, aborting (use -f to force output)

The offending references are in 3224eaca966088b4cf4f1ca3 (ARM64: dts:
meson-gxl: add support for the Khadas VIM board), there doesn't seem to
be anything providing those phandles in either mainline or -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/087a89ae/attachment.sig>
