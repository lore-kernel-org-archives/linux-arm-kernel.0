From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 30 Nov 2014 00:46:27 -0800
Subject: [PATCH v5 0/3] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <1417020793-3354-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417020793-3354-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141130084627.GD3608@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:53:10PM +0100, Boris Brezillon wrote:
> This series provides an implementation for raw accesses taking care of
> hidding the specific layout used by the GPMI controller.
> 
> Best Regards,
> 
> Boris
> 
> Changes since v4:
>  - fixed a few corner cases in gpmi_move_bits (tested it with:
>    https://github.com/bbrezillon/gpmi-move-bits-test/blob/master/gpmi-move-bits-test.c)

Thanks for this.

BTW, I was going to ask if you benchmarked the much simpler
simple_move_bits() version against the more complicated version here,
but I just ran it myself; the simple version performed about 10x slower
when testing on my PC. So I guess that can justify some extra
complexity!

>  - add documentation and comments for the new gpmi functions
> 
> Changes since v3:
>  - add comments to the gpmi_move_bits function
>  - extend raw read/write documentation
>  - move last part of the raw_page_read function into a conditional block
> 
> Changes since v2:
>  - fixed a bug in gpmi_move_bits
>  - add a raw_buffer field to be used when using raw access methods
>    (experienced memory corruptions when directly using page_buffer_virt
>    buffer)
>  - add raw OOB access functions

Other than my comment about move vs. copy, I think this looks good
enough.

Brian
