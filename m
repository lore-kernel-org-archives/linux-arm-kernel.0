From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 11 Sep 2018 11:35:09 +0100
Subject: [PATCH] dts: juno: Enable coresight tmc scatter gather in ETR
In-Reply-To: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
References: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180911103509.GA770@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/18 09:47, Suzuki K Poulose wrote:
> We do not enable scatter-gather mode in the TMC-ETR by default
> to prevent malfunctioning of systems where the ETR may not be
> properly connected to the memory subsystem to allow for simultaneous
> READ/WRITE transactions when used in SG mode. Instead we whitelist
> the platforms where we know that it is safe to use the mode.
>
> All revisions of Juno have a proper ETR connection and hence
> white list them.
>

Applied conditionally, this conflicts with the patch Mathieu has in his
branch. He needs to drop that so that I can take both of them via ARM SoC.

--
Regards,
Sudeep
