From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Dec 2015 14:52:06 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <15285750.UWXWiNJ6YU@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2157023.1Ftpc9ZciN@wuerfel> <20151213090959.GB1570@katana>
 <15285750.UWXWiNJ6YU@wuerfel>
Message-ID: <20151214135206.GA1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > What about not ifdeffing the inline function and keep the build error
> > whenever someone uses it without I2C_SLAVE being selected?
> 
> The inline function is only added there for the case that I2C_SLAVE is
> disabled, so that would be pointless.
> 
> However, what we could do is move the extern declaration outside of
> the #ifdef to make it always visible. The if(IS_ENABLED(CONFIG_I2C_SLAVE))
> check should then ensure that it never actually gets called, and we
> get a link error if some driver gets it wrong.

Yes, that's what I meant: move the whole function (as it was before your
patch) out of the CONFIG_I2C_SLAVE block. We should get a compiler error
even, because for !I2C_SLAVE, the client struct will not have the
slave_cb member.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/f70353ff/attachment-0001.sig>
