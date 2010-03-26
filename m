From: martinwguy@gmail.com (Martin Guy)
Date: Fri, 26 Mar 2010 15:40:01 +0000
Subject: [spi-devel-general] [PATCH v2 2/3] ep93xx: added chip revision
	reading function
In-Reply-To: <0D753D10438DA54287A00B02708426976368F66FD1@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<c222c3df9c94d9ec919817f640a953e4f45ae99b.1268930557.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B02708426976368AC725D@AUSP01VMBX24.collaborationhost.net>
	<20100325090638.GA20512@gw.healthdatacare.com>
	<0D753D10438DA54287A00B02708426976368F66FD1@AUSP01VMBX24.collaborationhost.net>
Message-ID: <56d259a01003260840sacc120ep7fd74ab2c33a8c4a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  For parts 1 and 3.
>
>  I tried testing them in my setup with the mmc_spi.c and sst25l.c drivers.  Both
>  did not work.  For some reason the data read is always either 0x00 or 0xff.
>
>  I will try to get some time this week/weekend to look into this.

I got these working with the Sim.One board without modification.
The data rate when dd'ing from the block device is slightly slower
than the Cirrus Logic patches (222kB/s instead of 235kB/s), and I got
the same kind of write errors at the same frequency as we did with the
Cirrus code, but this seems to be some problem with our board. Unlike
the CIrrus code, it successfully retries failed multi-block read
requests using single-block reads.

In case it's useful to you, I attach the first hack of the
modifications I made to the board description file
I'm not sure it's right, and I haven't coded in the use of the
MMC-card-present GPIO interrupt line yet, but it "seems to work" ^TM

    M
-------------- next part --------------
A non-text attachment was scrubbed...
Name: simone-add-mmc_spi-2.6.34.patch
Type: text/x-diff
Size: 2072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100326/1ffed33d/attachment.bin>
