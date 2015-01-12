From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 12 Jan 2015 11:13:49 +0100
Subject: [RFC 02/11] i2c: add quirk checks to core
In-Reply-To: <20150112095847.GD3625@ldesroches-Latitude-E6320>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <20150112095847.GD3625@ldesroches-Latitude-E6320>
Message-ID: <20150112101349.GA995@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I am not sure it will perfectly fit at91 quirks.

I think it does.

> The hardware can handle two messages by using the internal address
> feature. The internal address size is from one byte to three bytes. Then
> the length of the first message is limited to three but we don't have
> this constraint for the second one. If we have 'write then read' no problem
> but if we have two write messages, the second one will cause a quirk
> exceeded error.

Yeah, for this reason I seperated I2C_ADAPTER_QUIRK_COMB_WRITE_FIRST
out. The first message is checked against max_comb_write_len which is
set to 3 for your driver. The second is checked agains max_write_len
which is unset in your driver and thus can be of any length.

That should work, no?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/8f6c67bb/attachment.sig>
