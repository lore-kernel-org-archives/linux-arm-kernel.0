From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 04 Apr 2014 16:18:12 +0100
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <20140404144108.GD7528@n2100.arm.linux.org.uk>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
 <20140404144108.GD7528@n2100.arm.linux.org.uk>
Message-ID: <533ECD34.5030502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 15:41, Russell King - ARM Linux wrote:
>> The happens because the multi-platform mode may include ARCH_SPEAR13XX
>> and this forcibly engages DEBUG_UART_PL01X to provide some kind of
>> compatibility with single platform builds (SPEAr supports both single and
>> multi-platform). This in turn causes DEBUG_LL_INCLUDE to wedge at
>> debug/pl01x.S.
>>
>> Problem is fixed by only deploying the compatibility options for SPEAr
>> when ARCH_MULTIPLATFORM is not set.
> 
> I think it's probably about time we killed the def_bool and just made
> this a plain 'bool'.  The affected platforms should be using
> DEBUG_LL_UART_PL01X by now.

Ok.

Looking closely I think this will actually be better even for the single
platforms since today KConfig will not honour targeting DEBUG_LL at
EmbeddedICE or semihosting on the platforms that remain in the list.

Expect a v3...



Daniel.
