From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Jan 2014 12:41:34 +0000
Subject: [RFC v3 10/13] ahci_imx: Adjust for ahci_platform managing the
 clocks
In-Reply-To: <1390088935-7193-11-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-11-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119124134.GQ15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:52AM +0100, Hans de Goede wrote:
> +enum {
> +	CLK_SATA,
> +	CLK_SATA_REF,
> +	CLK_AHB
> +};

Err, so we now rely on the order that these clocks are specified in DT
rather than their name properties to provide the correct clock... that
sounds particularly fragile to me.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
