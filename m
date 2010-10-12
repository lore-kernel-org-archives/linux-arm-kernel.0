From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Oct 2010 09:24:49 +0100
Subject: [PATCH] amba: add name based matching
In-Reply-To: <1286636480-27454-1-git-send-email-rabin.vincent@stericsson.com>
References: <1286636480-27454-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <20101012082449.GA14109@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 08:31:20PM +0530, Rabin Vincent wrote:
> Some peripherals on the DBx500 family of SoCs have changes in their
> functionality and registers between different variants in the family but
> retain the same AMBA peripheral ID, making it impossible to distinguish
> between them in AMBA drivers with the current AMBA id_table.
> 
> To support this, add a name parameter to the amba_device and the amba_id
> and allow name based matching as a second level filter after the
> periphid match.

I am really not very happy with this without an explaination of the kinds
of differences there are.

We've been through these kinds of problems where hardware has claimed to
be implemented by 'ARM' (0x41 in the implementer byte) "for compatibility"
but are a different design with their own differences.  Eventually the
vendor was forced (as I understand by ARM Ltd) to change that.

This sounds like another one of these situations - it seems that the
lesson hasn't been learnt.
