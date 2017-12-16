From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 16 Dec 2017 12:08:45 +0800
Subject: [PATCH v5 04/13] arm64: kernel: Survive corrected RAS errors
 notified by SError
In-Reply-To: <20171215155101.23505-5-james.morse@arm.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-5-james.morse@arm.com>
Message-ID: <79ccc7df-802b-e25c-05cf-b1ecc7c05569@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/12/15 23:50, James Morse wrote:
> +	case ESR_ELx_AET_UER:	/* Uncorrected Recoverable */
> +		/*
> +		 * The CPU can't make progress. The exception may have
> +		 * been imprecise.
> +		 */
> +		return true;
        For Recoverable error (UER), the error has not been  silently propagated,
        and has not been architecturally consumed by the PE, and
        The exception is precise and PE can recover execution from the preferred return address of the exception.
        so I do not think it should be panic here if the SError come from user space instead of coming from kernel space.
> +
