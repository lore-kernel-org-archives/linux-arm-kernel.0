From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Feb 2016 12:38:54 +0000
Subject: [PATCH v5 3/5] mtd: devices: m25p80: add support for mmap read
 request
In-Reply-To: <56C2D731.6050306@ti.com>
References: <1449807000-6457-1-git-send-email-vigneshr@ti.com>
 <1449807000-6457-4-git-send-email-vigneshr@ti.com>
 <20160209193616.GN13270@sirena.org.uk> <56BC1D3E.5020203@ti.com>
 <20160212223711.GD18988@sirena.org.uk> <56C2D731.6050306@ti.com>
Message-ID: <20160216123854.GJ18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 01:30:49PM +0530, Vignesh R wrote:
> On 02/13/2016 04:07 AM, Mark Brown wrote:
> > On Thu, Feb 11, 2016 at 11:03:50AM +0530, Vignesh R wrote:
> >> On 02/10/2016 01:06 AM, Mark Brown wrote:

> >>> Looking at this I can't help but think that spi_flash_read() ought to
> >>> have the stub in rather than the caller.  But given that we're pretty
> >>> much only ever expecting one user I'm not 100% sure it actually matters.

> >> Well, my initial patch set passed long list of arguments to
> >> spi_flash_read(), but Brian suggested to use struct[1] in order to avoid
> >> unnecessary churn when things need changed in the API.

> > I don't see what that has to do with my point?

> AFAIU, your previous comment was to move initialization of
> spi_flash_read_message struct to spi_flash_read(). This would mean

No, not at all.  I'm talking about how we handle the case where we don't
have hardware support for this and need to implement it in software -
currently that's in a separate place to the place where we call the
driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/b4c89e33/attachment.sig>
