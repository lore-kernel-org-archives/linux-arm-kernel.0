From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 18:29:49 +0100
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <20140307171932.GU607@lukather>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140307160836.GM21483@n2100.arm.linux.org.uk>
 <20140307171932.GU607@lukather>
Message-ID: <20140307172949.GL28943@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Another question is... why do we need to check pd->dev.of_node here?
> > If CONFIG_RESET_CONTROLLER is set, we always try to get the reset
> > controller node, so drv_data->rstc is either going to be a valid
> > pointer, or it's going to be an error pointer - neither
> > reset_control_get() nor devm_reset_control_get return NULL.
> 
> Hmmm, right. I'll fix this in a later version.
> 
> Wolfram, do you want me to respin the patch making use of
> reset_get_optional introduced by Philip in its other mail?

I think I'd prefer both issues fixed with one patch like in "fixing up
reset controller handling".

And you might want to give a Tested- or Reviewed-by tag to Philipp's
patch if you are going to use it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/bdf0064e/attachment.sig>
