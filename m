From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Sun, 22 Oct 2017 12:27:57 +0000
Subject: [PATCH 03/11] arm: Kconfig: enable KASan
In-Reply-To: <20171019123453.GV20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-4-liuwenliang@huawei.com>
 <a3902e32-0141-9616-ba3e-9cbbd396b99a@gmail.com>
 <20171019123453.GV20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CEF0@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2017 01:22 AM, Russell King - ARM Linux wrote:
>On Wed, Oct 11, 2017 at 12:15:44PM -0700, Florian Fainelli wrote:
>> On 10/11/2017 01:22 AM, Abbott Liu wrote:
>> > From: Andrey Ryabinin <a.ryabinin@samsung.com>
>> > 
>> > This patch enable kernel address sanitizer for arm.
>> > 
>> > Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
>> > Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
>> 
>> This needs to be the last patch in the series, otherwise you allow
>> people between patch 3 and 11 to have varying degrees of experience with
>> this patch series depending on their system type (LPAE or not, etc.)
>
>As the series stands, if patches 1-3 are applied, and KASAN is enabled,
>there are various constants that end up being undefined, and the kernel
>build will fail.  That is, of course, not acceptable.
>
>KASAN must not be available until support for it is functionally
>complete.

Thanks for Florian Fainelli and Russell King's review.
I'm going to change it in the new version. 
