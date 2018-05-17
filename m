From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 16:09:12 +0900
Subject: [PATCH v2 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <20180330125047.13936-4-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
 <20180330125047.13936-4-ssuloev@orpaltech.com>
Message-ID: <20180517070912.GR20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2018 at 03:50:44PM +0300, Sergey Suloev wrote:

> There is no need to handle 3/4 empty/full interrupts as
> the maximum supported transfer length in PIO mode is
> 128 bytes for sun6i- and 64 bytes for sun8i-family SoCs.

Surely the whole point of the 3/4 full interrupts is to allow the FIFO
to be refilled and enable longer transfers?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/cc6ac43a/attachment-0001.sig>
