From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:52:39 +0100
Subject: [PATCH 05/26] mfd: ab8500-gpadc: Change to mdelay for greater
 resolution
In-Reply-To: <1358254566-12419-6-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235239.GM1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee, Jonas,

On Tue, Jan 15, 2013 at 12:55:45PM +0000, Lee Jones wrote:
> From: Jonas Aaberg <jonas.aberg@stericsson.com>
> 
> The resolution of msleep is related to HZ, so with HZ set to
> 100 any msleep of less than 10ms will become ~10ms.
usleep_range would be more appropriate, sleeping should be preferred over
spinning.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
