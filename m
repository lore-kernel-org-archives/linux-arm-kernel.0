From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 03 Dec 2012 10:27:46 -0700
Subject: [PATCH V7 3/7] arm64: use new common dtc rule
In-Reply-To: <20121129143041.GC30437@arm.com>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
 <1354058956-7199-3-git-send-email-swarren@wwwdotorg.org>
 <20121129143041.GC30437@arm.com>
Message-ID: <50BCE112.3050203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2012 07:30 AM, Catalin Marinas wrote:
> On Tue, Nov 27, 2012 at 11:29:12PM +0000, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The current rules have the .dtb files build in a different directory
>> from the .dts files. This patch changes arm64 to use the generic dtb
>> rule which builds .dtb files in the same directory as the source .dts.
>>
>> This requires moving parts of arch/arm64/boot/Makefile into newly created
>> arch/arm64/boot/dts/Makefile, and updating arch/arm64/Makefile to call the
>> new Makefile.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> I had a bit more clean-up in a local patch (see attached). Depending on
> the timing, you can just fold it into your patch (basically removing the
> MACHINE argument, adding KBUILD_DTBS and dtbs target help). It's been
> derived from your arch/arm patch anyway ;).

Thanks. Just to follow up on this, Rob has applied the series (minus
Xtensa) to a local tree, I believe intending to take it for 3.8(?), and
has included a modified version of this patch there (i.e. rebased onto
my series and hence slightly adjusted for it).
