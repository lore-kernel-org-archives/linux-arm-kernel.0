From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 13 Sep 2018 13:08:27 +0200
Subject: [PATCH v3 2/5] drm/dp: fix link probing for devices supporting
 DP 1.4+
In-Reply-To: <1535451894-2518-3-git-send-email-dkos@cadence.com>
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
 <CGME20180828102609epcas4p4946d20a22c2ccc6b6157dd9ca954db70@epcas4p4.samsung.com>
 <1535451894-2518-3-git-send-email-dkos@cadence.com>
Message-ID: <20180913110829eucas1p2de1f7f14c8dcf186d4b829c22920365e~T8Qbh1iEV3205832058eucas1p2W@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.08.2018 12:24, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
>
> DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
> DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from DP_DPCD_REV
> to DP_ADAPTER_CAP should be retrieved starting from DP_DPCD_REV_EXTENDED.
> All registers are copied except DP_DPCD_REV, DP_MAX_LINK_RATE and
> DP_DOWNSTREAMPORT_PRESENT which represent the "true capabilities" of DPRX
> device.
>
> Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT might
> falsely return lower capabilities to "avoid interoperability issues with some
> of the existing DP Source devices that malfunction when they discover the
> higher capabilities within those three registers.".
>
> Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved and read 0
> so it's safe to check against it even if DP revision is <1.4
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

Here and in next patches signed-off-by of the author is missing.

With that fixed:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
