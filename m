From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 29 Sep 2015 13:57:27 -0700
Subject: [PATCH v12 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1441242397-870-3-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
 <1441242397-870-3-git-send-email-stefan@agner.ch>
Message-ID: <20150929205727.GP31505@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pushed this patch to l2-mtd.git, as it looks pretty much good. Although,
I'd like raw read support...

On Wed, Sep 02, 2015 at 06:06:34PM -0700, Stefan Agner wrote:
> This adds hardware ECC support using the BCH encoder in the NFC IP.
> The ECC encoder supports up to 32-bit correction by using 60 error
> correction bytes. There is no sub-page ECC step, ECC is calculated
> always accross the whole page (up to 2k pages).
> 
> Limitations:
> - HW ECC: Only 2K page with 64+ OOB.
> - HW ECC: Only 24 and 32-bit error correction implemented.
> 
> Raw writes have been tested using the generic nand_write_page_raw
> implementation. However, raw reads are currently not possible
> because the controller need to know whether we are going to use
> the ECC mode already at NAND_CMD_READ0 command time. At this point
> we do not have the information whether it is a raw read or a
> regular read at driver level...

Hmm, can you get this in ecc.read_page_raw()?
