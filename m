From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 8 Oct 2014 22:24:40 +0800
Subject: [PATCH v3 0/3] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141008142437.GA9912@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 04:07:33PM +0200, Boris BREZILLON wrote:
> Hello Huang, Brian,
> 
> This is just a new proposal to support raw accesses in a more standard way
> in the GPMI driver.
> This series has been tested on an imx28 board.
> 
> Any suggestions are welcome.
> 
> Best Regards,
> 
> Boris
> 
> Changes since v2:
>  - fixed a bug in gpmi_move_bits
>  - add a raw_buffer field to be used when using raw access methods
>    (experienced memory corruptions when directly using page_buffer_virt
>    buffer)
>  - add raw OOB access functions

I tested this patch set today with the imx6dl-sabreauto board.

    NAND: Micron MT29F64G08CBABAWP
	8192MiB, MLC, page size: 8192, OOB size: 744

    ECC: 40bit

The result:

[ 3672.779009] ==================================================
[ 3672.784974] mtd_nandbiterrs: MTD device: 0
[ 3672.789480] mtd_nandbiterrs: MTD device size 16777216, eraseblock=2097152, page=8192, oob=744
[ 3672.798169] mtd_nandbiterrs: Device uses 1 subpages of 8192 bytes
[ 3672.804554] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[ 3672.812497] mtd_nandbiterrs: incremental biterrors test
[ 3672.818688] mtd_nandbiterrs: write_page
[ 3672.825529] mtd_nandbiterrs: rewrite page
[ 3672.837290] mtd_nandbiterrs: read_page
[ 3672.848407] mtd_nandbiterrs: error: read failed at 0x0
[ 3672.853644] mtd_nandbiterrs: After 0 biterrors per subpage, read reported error -74
[ 3672.862932] mtd_nandbiterrs: finished successfully.
[ 3672.867837] ==================================================

[ 3745.282368] ==================================================
[ 3745.288227] mtd_nandbiterrs: MTD device: 0
[ 3745.292913] mtd_nandbiterrs: MTD device size 16777216, eraseblock=2097152, page=8192, oob=744
[ 3745.301897] mtd_nandbiterrs: Device uses 1 subpages of 8192 bytes
[ 3745.308023] mtd_nandbiterrs: Using page=1, offset=8192, eraseblock=0
[ 3745.316778] mtd_nandbiterrs: incremental biterrors test
[ 3745.323017] mtd_nandbiterrs: write_page
[ 3745.328616] mtd_nandbiterrs: rewrite page
[ 3745.334191] mtd_nandbiterrs: read_page
[ 3745.346878] mtd_nandbiterrs: error: read failed at 0x2000
[ 3745.352352] mtd_nandbiterrs: After 0 biterrors per subpage, read reported error -74
[ 3745.361281] mtd_nandbiterrs: finished successfully.
[ 3745.366173] ==================================================


Is this okay? 

thanks
Huang Shijie
