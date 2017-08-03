From: james.morse@arm.com (James Morse)
Date: Thu, 03 Aug 2017 18:03:52 +0100
Subject: [PATCH v2 11/16] arm64: kernel: Handle deferred SError on kernel
 entry
In-Reply-To: <20170728141019.9084-12-james.morse@arm.com>
References: <20170728141019.9084-1-james.morse@arm.com>
 <20170728141019.9084-12-james.morse@arm.com>
Message-ID: <59835778.80702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 28/07/17 15:10, James Morse wrote:
> Before we can enable Implicit ESB on exception level change, we need to
> handle deferred SErrors that may appear on exception entry.

Christoffer has pointed out on patch 16 that I've miss-understood IESB's behaviour:
> The implicit form of Error Synchronization Barrier: [...] Has no effect on
> DISR_EL1

Turns out the ARM-ARM psuedocode means subtly different things by 'ESB' and
'ErrorSynchronizationBarrier'.

Patches 11->16 will need rethinking, but it looks like they can be simplified.


Thanks,

James
