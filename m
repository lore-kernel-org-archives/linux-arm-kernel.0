From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Mar 2018 09:55:43 +0000
Subject: [RFC PATCH 0/4] add support for CommonLPIAff field
In-Reply-To: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/18 06:49, Yang Yingliang wrote:
> This patch set adjust struct rdists to support CommonLPIAff field.
> This field is described in spec:
> 
> CommonLPIAff, bits [25:24]
> The affinity level at which Redistributors share a LPI Configuration table.
> 00 All Redistributors must share a LPI Configuration table.
> 01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
> 10 All Redistributors
> 11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration
> table.

What are you trying to achieve here? We already share the same
configuration table across all the redistributors, irrelevant the of
CommonLPIAff. Why would we need to do anything else?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
