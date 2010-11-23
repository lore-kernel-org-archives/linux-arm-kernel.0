From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Nov 2010 18:30:38 +0000
Subject: [PATCH 1/3] mfd: Added new regulator_data pointer to ab8500
	board configuration
In-Reply-To: <1290536754-21775-2-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
	<1290536754-21775-2-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <20101123183037.GA19212@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 07:25:52PM +0100, Bengt Jonsson wrote:

> The ab8500 regulator board configuration will be better separated
> from the MFD board configuration. This patch adds a void pointer
> for this purpose.

Adding something completely typesafe seems like a real loss - if you
want to point to something else at least point to a particular type -
eg, 

struct foo;

struct pdata {
	int other_stuff;
	struct foo *foo;
};

>  	struct regulator_init_data *regulator[AB8500_NUM_REGULATORS];
> +	void *regulator_data;

It'd also help if you could articulate the problem you see with the
current approach...
