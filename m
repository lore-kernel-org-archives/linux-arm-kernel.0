From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 24 Aug 2016 09:57:58 +0100
Subject: [PATCH] arm64: KVM: Enable support for Cortex-A72
In-Reply-To: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
References: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <ffda6889-5c31-1b56-942c-de65bbb1c16f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/16 08:21, Shannon Zhao wrote:
> In order to allow KVM to run on Cortex-A72 physical cpus, enable KVM
> support for Cortex-A72.

Do we really need this change ? Given that A72 is using the generic_v8 table,
it will automatically be supported via the GENERIC_V8 target. That was added
just for this purpose. The pre-existing targets were preserved so that
we don't break the ABI for older user space.

Suzuki
