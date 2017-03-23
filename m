From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 23 Mar 2017 08:44:07 -0700
Subject: next-20170323 build: 2 failures 4 warnings (next-20170323)
In-Reply-To: <20170323110249.3tf3tjo6c2y5qbkh@sirena.org.uk> (Mark Brown's
 message of "Thu, 23 Mar 2017 11:02:49 +0000")
References: <E1cqxc1-0004Cs-Lx@optimist>
 <20170323110249.3tf3tjo6c2y5qbkh@sirena.org.uk>
Message-ID: <m2a88cm20o.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Mar 23, 2017 at 07:56:49AM +0000, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 allmodconfig and defconfig due to:
>
>> 	arm64-allmodconfig
>> 	arm64-defconfig
>> ERROR (phandle_references): Reference to non-existent node or label "pwm_f_clk_pins"
>> ERROR (phandle_references): Reference to non-existent node or label "pwm_ao_a_3_pins"
>> ERROR: Input tree has errors, aborting (use -f to force output)
>
> The offending references are in 3224eaca966088b4cf4f1ca3 (ARM64: dts:
> meson-gxl: add support for the Khadas VIM board), there doesn't seem to
> be anything providing those phandles in either mainline or -next.

This was my fault, I backed it out soon after I committed, but it was
picked up by -next before I removed it.

Sorry for the noise,

Kevin
