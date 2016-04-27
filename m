From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 09:54:33 +0100
Subject: [PATCH V4 10/18] coresight: tmc: getting rid of multiple read
 access
In-Reply-To: <1461708634-6327-11-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-11-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57207E49.8050504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> Allowing multiple readers to access the trace data simultaniously
> via sysFS provides no shortage of opportunity for race condition,
> mandates two variable to be maintained (drvdata::read_count and
> drvdata::reading), makes the code complex and provide little
> advantages, if any.
>
> This patch streamlines the read process by restricting trace data
> access to a single user.  That way drvdata::read_count can
> be eliminated and race conditions (along with faulty error handling)
> in function tmc_open() and tmc_release() eliminated.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Nice!

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Suzuki
