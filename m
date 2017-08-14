From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Aug 2017 21:47:13 +0200
Subject: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
In-Reply-To: <1502674616.930.74.camel@mhfsdcap03>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
 <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
 <20170812144411.zqgbncsemzaolldv@ninjato>
 <1502674616.930.74.camel@mhfsdcap03>
Message-ID: <20170814194713.c6ojqcbi2iluayau@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 09:36:56AM +0800, Jun Gao wrote:
> On Sat, 2017-08-12 at 16:44 +0200, Wolfram Sang wrote:
> > > +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> > > +	.max_num_msgs = 255,
> > > +	.max_write_len = 65535,
> > > +	.max_read_len = 65535,
> > > +	.max_comb_1st_msg_len = 65535,
> > > +	.max_comb_2nd_msg_len = 65535,
> > > +};
> > 
> > That looks like no quirks? Then just leave the quirks pointer below
> > empty.
> > 
> Compare to MT8173 i2c controller, MT7622 limits message numbers to 255.

I see. But you can safely drop all the length settings. The i2c core has
this comment in quirk handling:

/* Check if val is exceeding the quirk IFF quirk is non 0 */

IFF means "if and only if".

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170814/80ee3163/attachment.sig>
