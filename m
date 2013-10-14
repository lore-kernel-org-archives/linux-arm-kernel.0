From: liuj97@gmail.com (Jiang Liu)
Date: Mon, 14 Oct 2013 23:24:50 +0800
Subject: [PATCH v2 0/7] Optimize jump label implementation on ARM64
In-Reply-To: <20131014151938.GJ10491@mudshark.cambridge.arm.com>
References: <1381675827-1610-1-git-send-email-liuj97@gmail.com>
 <20131014151938.GJ10491@mudshark.cambridge.arm.com>
Message-ID: <525C0CC2.7080305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 11:19 PM, Will Deacon wrote:
> On Sun, Oct 13, 2013 at 03:50:20PM +0100, Jiang Liu wrote:
>> From: Jiang Liu <jiang.liu@huawei.com>
>>
>> This patchset tries to optimize arch specfic jump label implementation
>> for ARM64 by dynamic kernel text patching.
>>
>> To enable this feature, your toolchain must support "asm goto" extension
>> and "%c" constraint extesion. Current GCC for AARCH64 doesn't support
>> "%c", so you need a GCC patch similiar to this:
>> http://gcc.gnu.org/viewcvs/gcc/trunk/gcc/config/arm/arm.c?view=patch&r1=175293&r2=175565&pathrev=175565
>> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
> 
> Right, but this is just for the ARM (AArch32) backend afaict. Are there any
> plans for upstream GCC to support this constraint for AArch64?
> 
> Will
> 
Hi Will,
	We have an internal GCC version with this issue fixed. But I'm not
familiar with GCC community and don't know the way to get the fix merged
into GCC mainstream. Any suggestion?
Thanks!
