From: rabin@rab.in (Rabin Vincent)
Date: Thu, 28 Jan 2010 22:37:28 +0530
Subject: [PATCH 08/13] ARM: LPC32XX: clock tree support
In-Reply-To: <1264643011-17390-9-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-9-git-send-email-wellsk40@gmail.com>
Message-ID: <20100128170728.GA14674@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 05:43:26PM -0800, wellsk40 at gmail.com wrote:
> +static struct clk_lookup lookups[] __initdata = {

This shouldn't be __initdata, since it'll be needed when loading modules
which use clk_get().

Rabin
