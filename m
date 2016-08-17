From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 11:39:35 +0100
Subject: [PATCH] ARM: dts: exynos: Use stdout non-deprecated property and
 add serial options to Odroid XU/XU3/XU4
In-Reply-To: <bae50bce-8e56-62cc-89b4-68532c2acaf0@samsung.com>
References: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
 <20160817102506.GD30900@leverpostej>
 <bae50bce-8e56-62cc-89b4-68532c2acaf0@samsung.com>
Message-ID: <20160817103935.GE30900@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 12:28:48PM +0200, Krzysztof Kozlowski wrote:
> On 08/17/2016 12:25 PM, Mark Rutland wrote:
> > On Wed, Aug 17, 2016 at 09:34:58AM +0200, Krzysztof Kozlowski wrote:
> >> The "linux,stdout-path" is deprecated.
> >>
> >> Add serial options so the console can be properly configured when
> >> bootloader does not pass "console" parameter to command line.  Without
> >> options and lack of "console", the serial output dies during boot (just
> >> after probing sound).
> > 
> > I'm confused. Is this just a cleanup (given "linux,stdout-path" is
> > deprecated but still supported), or a bug fix?
> 
> There is no bug, so rather this is cleanup and improvement in one.
> Usually we pass full console=ttySAC2,115200n8 from UBoot to command
> line. The usage of serial options allows skipping that.
> 
> I can split the cleanup part from improvement. To me it looked a little
> bit too much but I don't mind.

No need. It just wasn't clear to me that you had U-Boot configured to
pass the rate on the command line.

As I mentioned, I suspect that the serial output doesn't "die" as such,
but rather changes rate. It might be worth clarifying that in the commit
message, but either way the patch itself is fine, and it's no big deal.

Thanks,
Mark.
