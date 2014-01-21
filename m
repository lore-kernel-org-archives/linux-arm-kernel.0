From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 21 Jan 2014 16:33:21 -0700
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
In-Reply-To: <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140121233321.GR18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 06:12:31AM -0300, Ezequiel Garcia wrote:
> In order to support other SoC, it's required to distinguish
> the 'control' timer register, from the 'rstout' register
> that enables system reset on watchdog expiration.

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res)
> +		return -ENODEV;
           ^^^^^^^^^^^^^^^^^^^^^^

This change seems to break compatibility with existing DT files that
have only a single entry in reg?

Can the value be defaulted some how if missing?

Regards,
Jason
