From: tj@kernel.org (Tejun Heo)
Date: Sun, 12 Jan 2014 07:06:54 -0500
Subject: [PATCH v2 1/4] libahci: Add a pre ahci_start_engine hook
In-Reply-To: <1388826878-5602-2-git-send-email-hdegoede@redhat.com>
References: <1388826878-5602-1-git-send-email-hdegoede@redhat.com>
 <1388826878-5602-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140112120654.GC8509@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Jan 04, 2014 at 10:14:35AM +0100, Hans de Goede wrote:
> @@ -323,6 +323,8 @@ struct ahci_host_priv {
>  	u32			em_msg_type;	/* EM message type */
>  	struct clk		*clk;		/* Only for platforms supporting clk */
>  	void			*plat_data;	/* Other platform data */
> +	/* Optional pre ahci_start_engine hook */
> +	void			(*pre_start_engine)(struct ata_port *ap);

I'd much prefer if the callback overrides start_engine itself rather
than adding a hook inside start_engine.  This is a bit too specific.

Thanks.

-- 
tejun
