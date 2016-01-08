From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 09:49:52 +0100
Subject: [PATCH v6 05/21] arm64: compat: fix wrong dependency
In-Reply-To: <1452209679-19445-6-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-6-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <5385692.YG3TxTb2Ei@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 02:34:23 Yury Norov wrote:
> From: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> 
> With the patches of ILP32, COMPAT is not equivalent to AARCH32 in EL0.
> This patch fix this by updating the dependency from COMPAT to
> AARCH32_EL0 for ARMV8_DEPRECATED and ARM64_ERRATUM_845719.
> 
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 

I'd change the title of this patch: at this point in the series, the
dependency is not wrong yet, it just needs to be changed before
ARM64_ILP32 gets introduced.

	Arnd
