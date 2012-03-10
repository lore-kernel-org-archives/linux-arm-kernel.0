From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 10 Mar 2012 21:53:51 +0100
Subject: [PATCH v5 3/3] USB: ohci-nxp: Support for LPC32xx
In-Reply-To: <20120310204955.GA14564@pengutronix.de>
References: <1331408166-11607-1-git-send-email-stigge@antcom.de>
 <1331408166-11607-4-git-send-email-stigge@antcom.de>
 <20120310204955.GA14564@pengutronix.de>
Message-ID: <20120310205351.GB14564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 09:49:55PM +0100, Wolfram Sang wrote:
> 
> > -static void isp1301_configure(void)
> > +static u16 i2c_read16(u8 subaddr)
> > +{
> > +	u16 data;
> > +
> > +	i2c_master_send(isp1301_i2c_client, &subaddr, 1);
> > +	i2c_master_recv(isp1301_i2c_client, (u8 *) &data, 2);
> > +
> > +	return data;
> > +}
> 
> Won't i2c_smbus_read_word_data(isp1301_i2c_client, reg) do?
> 
> And while we are at it: Could you also try replacing i2c_write() with
> i2c_smbus_write_byte_data(isp1301_i2c_client, reg, val)?
> 
> No need to recode it (and in general, those solutions will also work with SMBus
> for free)

"no need to recode it" means "no need to recode these already existing functions"

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120310/53437b57/attachment-0001.sig>
