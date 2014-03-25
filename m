From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Mar 2014 17:31:38 +0100
Subject: [PATCH 0/5] ARM: shmobile: r8a7790: enable IIC(B) cores
In-Reply-To: <2570845.PngjMN9sWk@avalon>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <2570845.PngjMN9sWk@avalon>
Message-ID: <20140325163137.GD6374@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > This series allows r8a7790 boards to use the alternative IIC(B) controller
> > handled by the i2c-sh_mobile driver. Since both i2c cores always use the
> > same pins only in a different function group, you can easily use this or
> > that core for your devices. For that reason, there is currently no
> > enablement on the Lager board, since it needs discussion which core we want
> > to have on which bus. sh_mobile seems more stable currently, so I'd vote
> > for that.
> 
> Do you have a short list of pros and cons from a hardware point of view ?

iic has DMA capability for which we don't have software support yet.
Other than that, I guess it is just details and I haven't looked that deep
into the datasheets yet. That might be coming after this DT enablement.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/9a455eb8/attachment.sig>
