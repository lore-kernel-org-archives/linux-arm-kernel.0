From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Mar 2015 09:51:55 +0000
Subject: [PATCH 1/8] clk: add helper function clk_is_match()
In-Reply-To: <20150225172757.421.43718@quantum>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum>
Message-ID: <20150304095155.GB8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
> +static inline bool clk_is_match(struct clk *p, struct clk *q)
> +{
> +	return p == q ? true : false;

When they created the C standard, they already taught the compiler that
p == q returns a true / false boolean value; there's no need for ?: here.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
