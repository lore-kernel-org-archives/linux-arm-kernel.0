From: trini@konsulko.com (Tom Rini)
Date: Fri, 20 May 2016 21:41:59 -0400
Subject: [U-Boot] Sharing code between Linux and bootloader (U-boot) ?
In-Reply-To: <573F1F07.6040202@laposte.net>
References: <573F1F07.6040202@laposte.net>
Message-ID: <20160521014159.GK7650@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 04:28:23PM +0200, Sebastian Frias wrote:

> Hi,
> 
> Some bootloaders (like U-boot) support several HW devices: serial,
> network, NAND, USB, etc. most of which are also supported by Linux.
> 
> So the question is: is code shared? I mean, I understand that the
> drivers need to talk to the appropriate API, and such API could be
> different between Linux and U-boot.
> But putting that aside, would it be naive to imagine that some "core"
> functionality could be shared? Or would that part be so small it is
> not worth the effort?
> 
> Since many companies use both, U-boot and Linux, I would figure they
> try their best to optimize engineering resources and share code,
> right?
> In that case, I also wonder how do they share DT descriptions that
> right now are being stored in the Linux kernel tree.
> 
> We'd like to share code/DT for obvious reasons, what would you guys
> suggest?

So, in all cases, Linux is always the primary.  In some cases in U-Boot
we port drivers over (NAND is a good example here).  In other cases,
things are similar enough that it's having done it in one place it's
easy enough to do it again in the other.

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160520/085f7137/attachment.sig>
