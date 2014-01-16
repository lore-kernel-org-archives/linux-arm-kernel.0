From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jan 2014 13:47:32 +0000
Subject: [PATCH v3 7/7] ARM: brcmstb: dts: add a reference DTS for
 Broadcom 7445
In-Reply-To: <201401161219.01038.arnd@arndb.de>
References: <1389743333-16741-1-git-send-email-marc.ceeeee@gmail.com>
 <61E0E2A7-F7FC-4397-8E92-06CC409912B9@gmail.com>
 <52D72FCD.1030005@gmail.com> <201401161219.01038.arnd@arndb.de>
Message-ID: <20140116134732.GB17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:19:00PM +0100, Arnd Bergmann wrote:

> 1. Other platforms also require the syscon driver to be active before
> the regular device driver probing starts. Michal Simek has the same
> issue in the zynq clock driver that you have for SMP initialization.
> We have talked about this with Mark Brown already, and I think we will
> find a solution for this in the end, but it's not as straightforward
> as I first hoped. We can probably use help in this area.

I thought the solution with deferring registration of the resource for
dev_get_regmap() until a proper device materialised seemed simple and
enough, did you folks run into any problems with that?  I had assumed a
patch was likely to materialise so wasn't worrying about it myself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140116/e6781d1d/attachment.sig>
