From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 26 Sep 2015 19:23:54 +0200
Subject: [PATCH v3] drivers: power: twl4030_charger: fix link problems
 when building as module
In-Reply-To: <1443212447-5841-1-git-send-email-marek@goldelico.com>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
Message-ID: <20150926172353.GC22315@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Sep 25, 2015 at 10:20:45PM +0200, Marek Belisko wrote:
> If either twl4030_charger or twl4030_madc is configured as MODULE,
> we get build (link) errors.
> 
> To solve, the direct call of twl4030_get_madc_conversion() is replaced
> by a call to iio_read_channel_processed().
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>

Thanks, queued for 4.4 together with the DT binding patch.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150926/8cdd8bc4/attachment.sig>
