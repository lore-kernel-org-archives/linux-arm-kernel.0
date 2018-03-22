From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 22 Mar 2018 16:44:51 +0000
Subject: [PATCH v4 09/22] arm64: capabilities: Split the processing of
 errata work arounds
In-Reply-To: <20180313115120.17256-10-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-10-suzuki.poulose@arm.com>
Message-ID: <943b6c94-25a7-55dc-5eb4-29ab3eb893c9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/18 11:51, Suzuki K Poulose wrote:
> Right now we run through the errata workarounds check on all boot
> active CPUs, with SCOPE_ALL. This wouldn't help for detecting erratum
> workarounds with a SYSTEM_SCOPE. There are none yet, but we plan to
> introduce some: let us clean this up so that such workarounds can be
> detected and enabled correctly.
> 
> So, we run the checks with SCOPE_LOCAL_CPU on all CPUs and SCOPE_SYSTEM
> checks are run only once after all the boot time CPUs are active.
> 
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Changes since v3
  - Reworded commit description
  - Added Reviewed-by tag from Dave
