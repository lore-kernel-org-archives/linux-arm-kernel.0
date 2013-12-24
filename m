From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Dec 2013 13:51:27 +0000
Subject: [PATCH v5 1/3] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <1387852468-18073-1-git-send-email-wenyou.yang@atmel.com>
References: <1387852421-18033-1-git-send-email-wenyou.yang@atmel.com>
 <1387852468-18073-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131224135127.GC24814@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 10:34:28AM +0800, Wenyou Yang wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

I've applied this, however there is one small issue which I seem to have
forgotten to point out previously:

> +	/* Finally register devices */
> +	for (i = 0; i < pdata->num_regulators; i++) {

The driver should register all regulators regardless of how many are
used in the system in order to aid diagnostics.  Please send an
incremental patch to fix this.
