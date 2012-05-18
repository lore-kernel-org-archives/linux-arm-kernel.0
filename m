From: ajax@redhat.com (Adam Jackson)
Date: Fri, 18 May 2012 10:03:54 -0400
Subject: [PATCH 2/2] pcm038 lcdc support
In-Reply-To: <1337344032-25431-3-git-send-email-s.hauer@pengutronix.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <1337344032-25431-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337349834.29229.15.camel@atropine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-18 at 14:27 +0200, Sascha Hauer wrote:

> +			edid = [00 ff ff ff ff ff ff 00 4c 2d 6c 03 36 32 49 4b
> +				0f 13 01 03 80 37 22 a0 2a fe 21 a8 53 37 ae 24
> +				11 50 54
> +
> +				/* est timings */
> +				00 00 00
> +
> +				/* std timings */
> +				00 00
> +				00 00
> +				00 00
> +				00 00
> +				00 00
> +				00 00
> +				00 00
> +				00 00
> +
> +				/* detailed timings */
> +				05 0D 20 A0 30 58 1C 20 28 20 14 00 26 57 21 00 00 1E
> +				00 00 00 fd 00 32 4b 1b	51 11 00 0a 20 20 20 20 20 20
> +				00 00 00 fc 00 53 79 6e 63 4d 61 73 74 65 72 0a 20 20
> +				00 00 00 ff 00 48 39 58 53 34 30 30 34 34 32 0a 20 20
> +				00 20];

This EDID block claims to be a Samsung SyncMaster, which isn't really
the right thing to do.  The question is what to call it instead.  Red
Hat has a PNP ID we can use for virtual EDID blocks like this if we
want, I'd want to set up a little database to keep track of them but
that's pretty trivial.

Also, empty standard timing fields are 01 01, not 00 00.

- ajax
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/70b0e903/attachment.sig>
