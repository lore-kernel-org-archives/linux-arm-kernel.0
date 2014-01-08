From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Jan 2014 18:39:39 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1389201013-23794-3-git-send-email-broonie@kernel.org>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <1389201013-23794-3-git-send-email-broonie@kernel.org>
Message-ID: <20140108183939.GD9724@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:10:12PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>

[...]

> +		/* check if the cpu is marked as "disabled", if so ignore */
> +		if (!of_device_is_available(cn))
> +			continue;

This check must go. As I mentioned, either we define what this means properly
or to me the status property of cpu nodes must not be relied upon on ARM.

I can add a patch on top of your series that defines the behaviour for both
arm32 and arm64 when we reach agreement and code initializing
cpu_logical_map should be patched as well, accordingly.

Lorenzo
