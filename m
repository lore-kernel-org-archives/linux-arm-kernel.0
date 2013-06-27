From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 27 Jun 2013 14:39:48 -0700
Subject: [PATCH -v11 resend 10/11] arm,
 change reboot_mode to use enum reboot_mode
In-Reply-To: <CAGa+x85UP6_3n-m76w_NHMF5Ld-rEu+ufSbRbAE4RhdU7GuKnw@mail.gmail.com>
References: <1370519244-49918-1-git-send-email-holt@sgi.com>
 <12642293.RmlRtOVM54@wuerfel>
 <20130619102141.411c8e39.akpm@linux-foundation.org>
 <201306192016.00659.arnd@arndb.de>
 <CAGa+x87SZyOU3SWcBEUGKzke8whbHhudRzsj0VjgGU_VkhnJZA@mail.gmail.com>
 <CAGa+x85UP6_3n-m76w_NHMF5Ld-rEu+ufSbRbAE4RhdU7GuKnw@mail.gmail.com>
Message-ID: <CAGa+x85zxXEEYBC6569+48xjfO4VoDB0q4NSbVaj2JbWuEJRCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 2:28 PM, Kevin Hilman <khilman@linaro.org> wrote:
> On Tue, Jun 25, 2013 at 2:41 PM, Kevin Hilman <khilman@linaro.org> wrote:
>> On Wed, Jun 19, 2013 at 11:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wednesday 19 June 2013, Andrew Morton wrote:
>>>> This patchset gets a lot of rejects which I keep on fixing up.  Please
>>>> merge up early in the merge window and compile-test (and review) the
>>>> linux-next changes to make sure I didn't muck up the reject-fixing,
>>>> then we should be fine.
>>>
>>> Ok, good. The patch below is what I used locally to get everything to
>>> build. Please fold that into the larger patch.
>>
>> I'm still seeing build breaks in linux-next due to the original patch.
>>
>> Will the fix below from Arnd be folded into the original?
>
> Actually, there's even more ARM build fallout from this patch not
> covered by Arnd's fix.  For example, building the ixp4xx_defconfig now
> has an include nesting mess[1] that is not a trivial fixup (at least
> that I have found yet).
>
> IMO, this patch needs to be dropped from -next until it gets better
> build coverage testing on ARM.

OK, the change below also needs to be folded in to fix ixp4xxx_defconfig on ARM.

Kevin


diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h
b/arch/arm/mach-ixp4xx/include/mach/platform.h
index 4c4c6a6..8f81a5b 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -13,7 +13,7 @@

 #ifndef __ASSEMBLY__

-#include <linux/reboot.h>
+extern enum reboot_mode reboot_mode;

 #include <asm/types.h>
