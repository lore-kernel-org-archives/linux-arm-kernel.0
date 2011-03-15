From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Mar 2011 14:49:25 +0000
Subject: [PATCH 1/4] amba: add name based matching
In-Reply-To: <1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
References: <1300200116-12185-1-git-send-email-philippe.langlais@stericsson.com>
	<1300200116-12185-2-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20110315144925.GG3921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 03:41:53PM +0100, Philippe Langlais wrote:
> From: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> Some peripherals on the DBx500 family of SoCs have changes in their
> functionality and registers between different variants in the family but
> retain the same AMBA peripheral ID, making it impossible to distinguish
> between them in AMBA drivers with the current AMBA id_table.
> 
> To support this, add a name parameter to the amba_device and the amba_id
> and allow name based matching as a second level filter after the
> periphid match.

I really hate the idea of matching AMBA stuff by name.  Isn't there any
other solution to this?
