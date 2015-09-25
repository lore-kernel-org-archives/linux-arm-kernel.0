From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Sep 2015 12:38:10 +0100
Subject: [PATCH 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <1442413280-31885-8-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
 <1442413280-31885-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150925113808.GL6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 03:21:05PM +0100, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> This patch adds an infrastructure to keep track of the CPU feature
> registers on the system. For each register, the infrastructure keeps
> track of the system wide safe value of the feature bits. Also, tracks
> the which fields of a register should be matched strictly across all
> the CPUs on the system for the SANITY check infrastructure.
> 
> The feature bits are classified as one of SCALAR_MIN, SCALAR_MAX and DISCRETE
> depending on the implication of the possible values. This information
> is used to decide the safe value for a feature.
> 
> SCALAR_MIN - The smaller value is safer
> SCALAR_MAX - The bigger value is safer
> DISCRETE - We can't decide between the two, so a predefined safe_value is used.

Can documentation of the meanings of these be added somewhere in the
relevant header or in Documentation?

Cheers
---Dave

[...]
