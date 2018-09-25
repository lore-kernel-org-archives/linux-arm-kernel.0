From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 25 Sep 2018 13:18:42 +0200
Subject: [PATCH v5 2/5] drm/dp: fix link probing for devices supporting DP
 1.4+
In-Reply-To: <1537866837-4408-3-git-send-email-dkos@cadence.com>
References: <1537866837-4408-1-git-send-email-dkos@cadence.com>
 <1537866837-4408-3-git-send-email-dkos@cadence.com>
Message-ID: <18095829.BFmvNaydv0@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Damian,

Am Dienstag, 25. September 2018, 11:13:32 CEST schrieb Damian Kos:
> From: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> DP 1.4 introduced a DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit in
> DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
> DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
> DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
> DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
> "true capabilities" of DPRX device.
> 
> Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
> might falsely return lower capabilities to "avoid interoperability
> issues with some of the existing DP Source devices that malfunction
> when they discover the higher capabilities within those three
> registers.".
> 
> Before DP 1.4, DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT bit was reserved
> and read 0 so it's safe to check against it even if DP revision is
> <1.4
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Damian Kos <dkos@cadence.com>

in v4 you received a
	Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
for this patch. If a patch is largely unchanged from one version to another
please add these previously received tags to the commit message.
This prevents people from reviewing needlessly stuff twice ;-) .

So the above should read

----- 8< -----
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
----- 8< -----


Heiko
