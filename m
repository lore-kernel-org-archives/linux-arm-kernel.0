From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Mar 2016 15:01:09 +0000
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
 <20160322100615.GA2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6DB59@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <20160325150109.GF2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 25, 2016 at 01:41:16PM +0000, Lakshmi Sai Krishna Potthuri wrote:

As I'm fairly sure I've said before please fix your mail client to word
wrap within paragraphs at something substantially less than 80 columns.
Doing this makes your messages much easier to read and reply to.

> >This is really not what I'd expect to happen, I'd expect that these dummy
> >cycles would be in addition to the actual data (see my request for better
> >documentation...).  If they overlap with the data then what is the point in
> >specifying this?  It's more work for the host, what benefit do we get from
> >doing it over just handing it like a normal byte?

> len field in the transfer structure contains dummy bytes along with actual data
> bytes, controllers which requires dummy bytes use len field and simply Ignore
> the dummy field (contains only no of cycles)added in this patch. Controllers
> (like ZynqMP GQSPI) expects dummy in cycles won't work directly by using
> len field because host driver doesn't know that len field of a particular transfer
> includes dummy bytes or not (and also number of dummy bytes included in len
> field). In such cases driver use this dummy field to identify the number of dummy
> cycles and based on that it will send the required number of dummy cycles (which
> i did in the second patch).

This doesn't make any sense at all to me.  Why does the controller care
what the bytes being sent to and from the device mean?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160325/71b76a17/attachment.sig>
