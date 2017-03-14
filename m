From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 14 Mar 2017 09:40:07 +0000
Subject: [PATCH] clocksource: add missing line break to error messages
In-Reply-To: <20170309094710.31003-1-zajec5@gmail.com>
References: <20170309094710.31003-1-zajec5@gmail.com>
Message-ID: <959bfbfb-177f-3e92-0a2c-1e283966b961@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/17 09:47, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> Printing with pr_* functions requires adding line break manually.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

I've had a quick look over and there are no obvious errors.

I wonder if the of_iomap() and related calls should print an
error if they fail as all the examples here are of the form
of:

	ptr = of_iomap(reource)
	if (!ptr) {
		pr_err("cannot remap resource\n");
		...
		return ERR;
	}

Maybe we should look into this post this patch series.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
