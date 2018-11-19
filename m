From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Nov 2018 15:18:33 +0100
Subject: [PATCH] drm/rockchip: fix for mailbox read size
In-Reply-To: <1541518625-25984-1-git-send-email-dkos@cadence.com>
References: <1541518625-25984-1-git-send-email-dkos@cadence.com>
Message-ID: <7088529.fTnRXqZmiP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 6. November 2018, 16:37:05 CET schrieb Damian Kos:
> Some of the functions (like cdn_dp_dpcd_read, cdn_dp_get_edid_block)
> allow to read 64KiB, but the cdn_dp_mailbox_read_receive, that is
> used by them, can read only up to 255 bytes at once. Normally, it's
> not a big issue as DPCD or EDID reads won't (hopefully) exceed that
> value.
> The real issue here is the revocation list read during the HDCP
> authentication process. (problematic use case:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/rockchip/cdn-dp-reg.c#1152)
> The list can reach 127*5+4 bytes (num devs * 5 bytes per ID/Bksv +
> 4 bytes of an additional info).
> In other words - CTSes with HDCP Repeater won't pass without this
> fix. Oh, and the driver will most likely stop working (best case
> scenario).
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>

applied to drm-misc-next

Thanks
Heiko
