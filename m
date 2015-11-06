From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 06 Nov 2015 09:39:07 -0800
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <20151106173558.GC7637@e104818-lin.cambridge.arm.com>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com> <20151106125002.GA8116@leverpostej>
 <20151106162109.GZ7637@e104818-lin.cambridge.arm.com>
 <20151106162538.GU6087@arm.com> <563CE21A.6060803@linaro.org>
 <20151106173558.GC7637@e104818-lin.cambridge.arm.com>
Message-ID: <563CE5BB.2080701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2015 9:35 AM, Catalin Marinas wrote:
> On Fri, Nov 06, 2015 at 09:23:38AM -0800, Shi, Yang wrote:
>> On 11/6/2015 8:25 AM, Will Deacon wrote:
>>> However, the patch would allow one to
>>> disable FRAME_POINTERS (not sure it has any effect on the aarch64 gcc
>>> though).
>>
>> No, it doesn't. Actually, FRAME_POINTER could be disabled regardless of the
>> patch.
>
> In which case I suggest that we always select it just as a clearer
> statement that the feature cannot be disabled (and you never know what
> the compiler people decide to do in the future).

Do you mean select FRAME_POINTER in ARCH_WANT_FRAME_POINTERS?

Yes, we could, but this may cause other architectures which select 
ARCH_WANT_FRAME_POINTERS to have FRAME_POINTER selected too.

Or we could do:

select FRAME_POINTER is ARM64

Thanks,
Yang

>
