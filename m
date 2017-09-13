From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 13 Sep 2017 06:36:18 -0700
Subject: [PATCH v2 09/28] arm64/sve: Signal frame and context structure
 definition
In-Reply-To: <1504198860-12951-10-git-send-email-Dave.Martin@arm.com>
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com>
 <1504198860-12951-10-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170913133618.lclorawve7364xxi@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 06:00:41PM +0100, Dave P Martin wrote:
> +/*
> + * The SVE architecture leaves space for future expansion of the
> + * vector length beyond its initial architectural limit of 2048 bits
> + * (16 quadwords).
> + */
> +#define SVE_VQ_BYTES		0x10	/* number of bytes per quadword */
> +
> +#define SVE_VQ_MIN		1
> +#define SVE_VQ_MAX		0x200

Just a nitpick (up to you): could you use 16 and 512 here instead of
hex? I usually associate hex numbers with some bit fields.

-- 
Catalin
