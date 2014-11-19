From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Nov 2014 09:34:45 +0000
Subject: [PATCH v2 1/4] spi: Add 'last' flag to spi_transfer structure
In-Reply-To: <20141118225546.GA27182@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-2-git-send-email-b.galvani@gmail.com>
 <20141118140658.GI22111@sirena.org.uk>
 <20141118225546.GA27182@gmail.com>
Message-ID: <20141119093445.GV22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 11:55:46PM +0100, Beniamino Galvani wrote:

> Would it be better to introduce something like:

> static inline bool
> spi_transfer_is_last(struct spi_master *master, struct spi_transfer *xfer)
> {
>         return list_is_last(&xfer->transfer_list, &master->cur_msg->transfers);
> }

> or open code it in the driver?

Adding the helper function seems better, it means we can change the
implementation later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/c10e4109/attachment-0001.sig>
