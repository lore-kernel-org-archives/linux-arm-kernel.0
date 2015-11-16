From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Nov 2015 10:35:01 -0800
Subject: [PATCH, resend] scsi: advansys: fix big-endian builds
In-Reply-To: <20151116182031.GX8644@n2100.arm.linux.org.uk>
References: <4411376.blKgWIg75B@wuerfel>
 <20151116182031.GX8644@n2100.arm.linux.org.uk>
Message-ID: <20151116183501.GA25744@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 06:20:31PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 16, 2015 at 05:49:23PM +0100, Arnd Bergmann wrote:
> > It turns out that the commit that introduced this used the cpu_to_le32()
> > incorrectly on an 8-bit field, which results in the sense_len to always
> > be set to zero, as the SCSI_SENSE_BUFFERSIZE value gets moved to upper
> > byte of the 32-bit intermediate.
> 
> More people need to run the sparse checker with -D__CHECK_ENDIAN__ and
> have proper endian annotations?

Ho about enabling __CHECK_ENDIAN__ by default when running sparse at
least?
