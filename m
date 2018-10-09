From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 9 Oct 2018 13:02:10 +0200
Subject: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
In-Reply-To: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
Message-ID: <20181009110210.i6xphyuy5jkcfaug@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> Some drivers need to find the device on a bus having a specific firmware
> node. Currently, such drivers have their own implementations to do this.
> Provide a helper similar to bus_find_device_by_name so that each driver
> does not have to reinvent this.
> 
> Signed-off-by: Silesh C V <svellattu@mvista.com>

Looks good in general, however:

We recently had this discussion in I2C world about using the parent if
the (logical) device has a NULL fw_node [1]. I don't know if the other
subsystems you modify use logical devices as well? If no, it seems we
need an additional check for the parent in the I2C core only. If yes,
this might be considered in your patchset?

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/974584/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181009/9920d913/attachment.sig>
