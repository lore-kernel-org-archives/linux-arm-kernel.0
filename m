From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 22 Aug 2013 11:06:47 +0200
Subject: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <5215C07D.7040000@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
 <20130821210116.GA3130@katana>
 <5215C07D.7040000@free-electrons.com>
Message-ID: <20130822090647.GA3491@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> @@ -326,6 +463,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
> >>  			drv_data->reg_base + drv_data->reg_offsets.control);
> >>  		break;
> >>  
> >> +	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
> >> +		if (mv64xxx_i2c_offload_msg(drv_data) <= 0)
> > 
> > needs to be adjusted when using -EINVAL above. I'd prefer the error case
> > in the else branch, though. Easier to read.
> > 
> 
> OK, but in this case ...
> 
> >> +			break;
> >> +		else
> >> +			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
> >> +		/* FALLTHRU */
> 
> ... the fall through here is less readable. But it is a matter of
> taste, I will change this.

Ah, I see. Well, try both and decide.

Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/3a92435b/attachment-0001.sig>
