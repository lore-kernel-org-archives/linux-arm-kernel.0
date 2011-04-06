From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Wed, 6 Apr 2011 10:49:20 +0200
Subject: [PATCHv5 1/3] ARM: Translate delay.S into (mostly) C
In-Reply-To: <1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>
	<1302047800-26720-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D9C2910.6020309@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:56 AM, Stephen Boyd wrote:
> +void __udelay(unsigned long usecs)
> +{
> +	__const_udelay(usecs * ((2199023*HZ)>>11));
This will overflow if HZ=1000.
If I remember correct I fixed it like this:
__const_udelay(usecs * ((2199023UL*HZ)>>11));

/Mattias Wallin
