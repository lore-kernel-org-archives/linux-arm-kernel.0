From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Mar 2015 18:15:40 +0000
Subject: [PATCH] arm64: remove __switch_data object from head.S
In-Reply-To: <1425385667-16082-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425385667-16082-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150303181540.GD10239@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

> +	str	x22, [x4, :lo12:processor_id]	// Save processor ID

We should just get rid of processor_id. It doesn't make sense given
big.LITTLE, we have the information stored per-cpu in cpu_data, and as
far as I can tell nothing relies on it currently.

Thanks,
Mark.
