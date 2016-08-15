From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 15 Aug 2016 16:59:41 +0200
Subject: [V2, 10/15] mmc: sdhci-esdhc-imx: enable hw auto retuning for
 MAN_TUNING
In-Reply-To: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-11-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160815145941.GA23663@t450s.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dong Aisheng, All,

On Tue, Jul 12, 2016 at 03:46:19PM +0800, Dong Aisheng wrote:
> Indicating hw auto retuning support for mx6qdl in the fake caps_1
> register and enable auto retuning in post_tuning process after
> tuning completes.

Have you tried this change with a SDIO3.0 device? I'm asking because a
similar change in latest NXP 4.1.15 kernel broke SDIO3.0 support.
With this tuning, the kernel would report:
mmc2: Got data interrupt 0x00000002 even though no data operation was in
progress.

Doing a 'git bisect' and then reverting this patch fixed the issue.
Although I haven't tested that change on mainline kernel, I wanted you
to know about this observation before it gets merged.

As a FYI, the issue has been reported to NXP community:
https://community.nxp.com/thread/431316

Regards,
Gary
