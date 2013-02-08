From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 17:26:08 +0200
Subject: [PATCH] ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for
 all CPU power states except off
In-Reply-To: <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
References: <1360336306-18277-1-git-send-email-santosh.shilimkar@ti.com>
 <1360336306-18277-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130208152607.GJ23979@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 08:41:46PM +0530, Santosh Shilimkar wrote:
> Current CPU PM code code make use of common cpu_suspend() path for all the
> CPU power states which is not optimal. In fact cpu_suspend() path is needed
> only when we put CPU power domain to off state where the CPU context is lost.
> 
> Update the code accordingly so that the expensive cpu_suspend() path
> can be avoided for the shallow CPU power states like CPU PD INA/CSWR.
> 
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

some numbers showing the benefit would be cool...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/e0a56f93/attachment.sig>
