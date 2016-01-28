From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 28 Jan 2016 17:55:17 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <20160128174428.GD17552@devel.intra.reserved-bit.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
 <20160126160257.GB28238@arm.com> <56A79D17.2000009@arm.com>
 <20160126165538.GC22776@devel.intra.reserved-bit.com>
 <20160128160747.GN775@arm.com>
 <20160128164631.GC17552@devel.intra.reserved-bit.com>
 <20160128172705.GC20099@e104818-lin.cambridge.arm.com>
 <20160128174428.GD17552@devel.intra.reserved-bit.com>
Message-ID: <56AA5605.8090903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 17:44, Siddhesh Poyarekar wrote:
> On Thu, Jan 28, 2016 at 05:27:05PM +0000, Catalin Marinas wrote:
>> Suzuki's MRS emulation only exposes the CPU feature registers and not
>> the MIDR. So this would help with choosing implementation based on
>> features (e.g. crypto) but not for micro-architecture tuning.
>
> Umm, I'm pretty sure it does, at least the patchset I tested back in
> October did.  I think you may be confusing with revidr.

It does expose MIDR, but with an exception that it provides that of
the CPU where mrs was executed (as documented), unlike the CPU feature
registers which guarantee a system wide view.

Thanks
Suzuki
