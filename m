From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Mar 2016 09:04:49 +0000
Subject: dtbs_install recursing on subdirs-y and dtbs-subdir leading to
 race?
In-Reply-To: <1458118474.28250.54.camel@debian.org>
References: <1458118474.28250.54.camel@debian.org>
Message-ID: <20160316090449.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 08:54:34AM +0000, Ian Campbell wrote:
> Where it appears that multiple instance of __dtbs_install_prep have
> been running in parallel at least the apm and arm subdirectories of
> arch/arm64/boot/dts, with both of them then racing in the?
>     $(Q)if [ -d $(INSTALL_DTBS_PATH) ]; then mv $(INSTALL_DTBS_PATH) $(INSTALL_DTBS_PATH).old; fi
> rule since apparently $(INSTALL_DTBS_PATH) existed during the "-d"
> check but had gone by the time of the move.

I've already sent a patch several times to remove this line, I believe
it's finally queued for this merge window.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
