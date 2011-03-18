From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 15:20:12 +0000
Subject: [PATCH v2 4/9] lpc2k: generic time and clockevents
In-Reply-To: <1300461116-6028-5-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-5-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110318152012.GM29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 04:11:51PM +0100, Ithamar R. Adema wrote:
> +	clk = clk_get(NULL, "timer1");
> +	BUG_ON(IS_ERR(clk));
> +
> +	clk_enable(clk);
> +	rate = clk_get_rate(clk);
> +	clk_put(clk);

Don't put a clock that you continue to use.
