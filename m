From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 10:15:54 -0600
Subject: ARM_ATAG_DTB_COMPAT fails on fdt_ro.c compiling
In-Reply-To: <20121009050109.GD21822@S2101-09.ap.freescale.net>
References: <20121009031715.GC21822@S2101-09.ap.freescale.net>
 <alpine.LFD.2.02.1210090018470.16518@xanadu.home>
 <20121009050109.GD21822@S2101-09.ap.freescale.net>
Message-ID: <50744DBA.3070900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 11:01 PM, Shawn Guo wrote:
> On Tue, Oct 09, 2012 at 12:25:44AM -0400, Nicolas Pitre wrote:
>> On Tue, 9 Oct 2012, Shawn Guo wrote:
>>
>>> I have seen this error on mainline for a couple days when
>>> ARM_ATAG_DTB_COMPAT is enabled.
>>>
>>>   CC      arch/arm/boot/compressed/fdt_ro.o
>>> arch/arm/boot/compressed/fdt_ro.c: In function ?fdt_path_offset?:
>>> arch/arm/boot/compressed/fdt_ro.c:172:3: error: implicit declaration of function ?fdt_get_alias_namelen? [-Werror=implicit-function-declaration]
>>> arch/arm/boot/compressed/fdt_ro.c:172:5: warning: assignment makes pointer from integer without a cast [enabled by default]
>>> arch/arm/boot/compressed/fdt_ro.c: At top level:
>>> arch/arm/boot/compressed/fdt_ro.c:340:13: error: conflicting types for ?fdt_get_alias_namelen?
>>> arch/arm/boot/compressed/fdt_ro.c:172:7: note: previous implicit declaration of ?fdt_get_alias_namelen? was here
>>> cc1: some warnings being treated as errors
>>
>> I just tried building mainline now.  It is at commit f5a246eab9.
>>
> The build still fails for me at this commit.

I can't reproduce this.

I tried both my local next-20121005-based dev branch and that exact
commit above. I tried both the crosstool-ng-based compiler I normally
use and Ubuntu 10.04's ARM compiler (possibly from a PPA). In both
cases, I ran git clean -f -d -x ; git reset --hard HEAD first, and then
build zImage, dtbs, and modules, and of course used your attached .config.
