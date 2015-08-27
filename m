From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 27 Aug 2015 17:17:11 +0100
Subject: [PATCH] arm: Handle starting up in secure mode
In-Reply-To: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
References: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
Message-ID: <55DF3807.40506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/15 14:55, Christopher Covington wrote:
> ARM Linux appears to have never been made aware of the ARMv7 security
> extensions. When CONFIG_ARM_SEC_EXT=y, have it probe for its security
> state by checking whether CNTFRQ is writeable and potentially make
> mode changes based on the information. The most features are available
> from hypervisor (HYP) mode, so switch to it possible. Failing that,
> prefer non-secure supervisor (SVC) mode to secure supervisor mode.

If there is no hypervisor mode available what benefit do we get from 
transitioning to non-secure mode?

When running in secure mode we retain access to some potentially useful 
features such as having access to FIQ.


Daniel.
