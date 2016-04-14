From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 18:39:48 +0100
Subject: [PATCH 4/5] arm64: Verify CPU errata work arounds on hotplugged
 CPU
In-Reply-To: <1459941854-5190-5-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160414173948.GO4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 12:24:13PM +0100, Suzuki K Poulose wrote:
> CPU Errata work arounds are detected and applied to the
> kernel code at boot time and the data is then freed up.
> If a new hotplugged CPU requires a work around which
> was not applied at boot time, there is nothing we can
> do but simply fail the booting.

Hmm, wouldn't it be better not to free the alternative text for errata
workarounds instead?

Will
