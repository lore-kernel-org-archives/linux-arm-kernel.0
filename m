From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Dec 2011 10:30:27 +0000
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111230103026.GA2766@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 02:06:53PM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@freescale.com>
> 
> Fix fixed regulator failed to call regulator_register.
> 
> Fixed regulator does not support set voltage operation, so we
> don't need apply_uV.

No, the regulator drivers shouldn't be fiddling around with their
constraints.  Generally the answer is that users shouldn't set
constraints that won't work, or perhaps the API needs to be more
forgiving.
