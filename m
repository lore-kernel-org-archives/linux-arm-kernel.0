From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 08 May 2012 10:11:46 +0300
Subject: [PATCH v2 3.4-rc6] MTD: NAND: ams-delta: fix
 request_mem_region() failure
In-Reply-To: <1336460605.23308.8.camel@sauron.fi.intel.com>
References: <20120504171125.GD5613@atomide.com>
 <1336423897-31729-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1336460605.23308.8.camel@sauron.fi.intel.com>
Message-ID: <1336461106.23308.12.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-08 at 10:03 +0300, Artem Bityutskiy wrote:
> On Mon, 2012-05-07 at 22:51 +0200, Janusz Krzysztofik wrote:
> > A call to request_mem_region() has been introduced in the omap-gpio
> > driver recently (commit 96751fcbe5438e95514b025e9cee7a6d38038f40,
> > "gpio/omap: Use devm_ API and add request_mem_region"). This change
> > prevented the Amstrad Delta NAND driver, which was doing the same in
> > order to take control over OMAP MPU I/O lines that the NAND device hangs
> > off, from loading successfully.
> 
> Aiaiai found out that your patch adds this gcc warning:
> 
> --------------------------------------------------------------------------------
> 
> Successfully built configuration "l2_omap1_defconfig,arm,arm-unknown-linux-gnueabi-", results:
> 
> --- before_patching.log
> +++ after_patching.log
> @@ @@
> +drivers/mtd/nand/ams-delta.c: In function 'ams_delta_cleanup':
> +drivers/mtd/nand/ams-delta.c:285:19: warning: unused variable 'res' [-Wunused-variable]
> 
> --------------------------------------------------------------------------------

But I've fixed this up and pushed to l2-mtd.git. From the commit message
I have an impression that you are not going to implement that longer
term plan. Dunno if Tony has a plan to force someone to do this by
blocking some changes which are not urgent fixes. Hmm? :-)

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/8682daf4/attachment.sig>
