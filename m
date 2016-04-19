From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 19 Apr 2016 14:07:08 +0100
Subject: [PATCH V2 08/15] coresight: tmc: getting the right read_count on
 tmc_open()
In-Reply-To: <1460483692-25061-9-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-9-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57162D7C.7040003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 18:54, Mathieu Poirier wrote:
> In function tmc_open(), if tmc_read_prepare() fails variable
> drvdata->read_count is not decremented, causing unwanted
> access to drvdata->buf and very likely, a crash dump.
>
> By moving the incrementation to a place where we know things
> are stable this kind of situation is avoided.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
