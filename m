From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 12 Oct 2010 14:16:23 +0530
Subject: [PATCH] amba: add name based matching
In-Reply-To: <20101012082449.GA14109@n2100.arm.linux.org.uk>
References: <1286636480-27454-1-git-send-email-rabin.vincent@stericsson.com>
	<20101012082449.GA14109@n2100.arm.linux.org.uk>
Message-ID: <20101012084623.GA20407@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 12, 2010 at 10:24:49 +0200, Russell King - ARM Linux wrote:
> On Sat, Oct 09, 2010 at 08:31:20PM +0530, Rabin Vincent wrote:
> > Some peripherals on the DBx500 family of SoCs have changes in their
> > functionality and registers between different variants in the family but
> > retain the same AMBA peripheral ID, making it impossible to distinguish
> > between them in AMBA drivers with the current AMBA id_table.
> > 
> > To support this, add a name parameter to the amba_device and the amba_id
> > and allow name based matching as a second level filter after the
> > periphid match.
> 
> I am really not very happy with this without an explaination of the kinds
> of differences there are.

For example:

 - The PL180 derivate has the ID 0x00480180 on both DB8500v1 and
   DB8500v2, but the DB8500v2 version moves the BLOCKSIZE in the
   DATACTRL register from a power of two at bits 7:4 to a normal value
   at bits 30:16.  The bits 7:4 become reserved in DB8500v2.

 - The PL022 derivate has the ID 0x00080023 on DB8500 and DB5500, but
   the DB5500 version has the "Loopback enable" bit, while the DB8500
   version doesn't.

Rabin
