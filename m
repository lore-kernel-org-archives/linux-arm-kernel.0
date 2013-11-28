From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Nov 2013 10:11:54 +0000
Subject: [PATCH] ARM: asm: Configure caches as per the defconfig
In-Reply-To: <5296D7DF.202@st.com>
References: <1385553244-1513-1-git-send-email-amit.virdi@st.com>
 <20131127121425.GN16735@n2100.arm.linux.org.uk> <5296D7DF.202@st.com>
Message-ID: <20131128101154.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 11:12:55AM +0530, Amit Virdi wrote:
> On 11/27/2013 5:44 PM, Russell King - ARM Linux wrote:
>> On Wed, Nov 27, 2013 at 05:24:04PM +0530, Amit Virdi wrote:
>>> From: Amit VIRDI <Amit.VIRDI@st.com>
>>>
>>> In the current implementation of the decompression code, the caches are enabled
>>> irrespective of their configuration in the deconfig. This makes setting the
>>> ICACHE and DCACHE disable options from the menuconfig irrelevant. Change this
>>> implementation to enable caches only if specified in the defconfig.
>>
>> NAK.  These options are provided more for ARM Ltd's validation of CPUs
>> rather than for users, and it's not supposed to be used with the
>> decompressor.
>>
>
> It is perfectly true that these options are used only during CPU  
> validations and not in the end product. Still, it doesn't justify why  
> these options are not to be used with decompressor. Or alternately, why  
> would a user intend to disable a cache when it has been implemented  
> correctly and is stable? Without this change, the effect of disabling  
> cache is not reflected in entirety.

When doing CPU validations, the compressed image isn't used.
