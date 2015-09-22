From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 22 Sep 2015 23:29:38 +0200
Subject: [PATCH v2 1/3] drivers: power: twl4030_charger: fix link
 problems when building as module
In-Reply-To: <1442953171-19718-1-git-send-email-marek@goldelico.com>
References: <1442953171-19718-1-git-send-email-marek@goldelico.com>
Message-ID: <20150922212900.GB15646@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Tue, Sep 22, 2015 at 10:19:29PM +0200, Marek Belisko wrote:
> If either twl4030_charger or twl4030_madc is configured as MODULE,
> we get build (link) errors.
> 
> To solve, the direct call of twl4030_get_madc_conversion() is replaced
> by a call to iio_read_channel_processed().
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
> changes from V1: added missing iio_channel_release + document and add new DT bindings

That was fast :) Patchset looks fine to me except for one last
thing: Let's make the iio-channel optional, so that old DT blobs
are still supported. Also the IS_REACHABLE(CONFIG_TWL4030_MADC)
check can be removed, it should no longer be needed with
iio_read_channel_processed().

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/fb16f255/attachment.sig>
