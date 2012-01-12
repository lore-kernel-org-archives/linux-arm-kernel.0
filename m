From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 12 Jan 2012 11:13:38 +0200
Subject: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after dss_core
In-Reply-To: <1325028693-14728-1-git-send-email-yanok@emcraft.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
 <1325028693-14728-1-git-send-email-yanok@emcraft.com>
Message-ID: <1326359618.2065.4.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2011-12-28 at 00:31 +0100, Ilya Yanok wrote:
> dss_core has to be initialized before any other DSS hwmod. Currently
> this is broken as dss_core is listed in chip/revision specific hwmod
> lists while other DSS hwmods are listed in common list which is
> registered first.
> 
> This patch moves DSS hwmods (except for dss_core) to the separate list
> which is registered last to ensure that dss_core is already registered.
> 
> This solves the problem with BUG() in L3 interrupt handler on boards
> with DSS enabled in bootloader.

I can ack this patch as a concept. The dss_core has to be initialized
before other dss hw modules. I can't say if the implementation here is
good or not, I don't know enough about hwmod.

Paul?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120112/3af45e9a/attachment.sig>
