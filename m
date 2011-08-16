From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Aug 2011 09:34:40 +0300
Subject: [PATCH v2] i2c: tegra: Check for overflow errors with BUG_ON.
In-Reply-To: <1313458336-31456-1-git-send-email-dianders@chromium.org>
References: <1313434172-18319-1-git-send-email-dianders@chromium.org>
	<1313458336-31456-1-git-send-email-dianders@chromium.org>
Message-ID: <20110816063439.GB2223@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 06:32:16PM -0700, Doug Anderson wrote:
> This change doesn't fix any known problems but turns
> on the overflow detection feature of the i2c controller
> in the hopes of flushing out any current (or future)
> bugs in the i2c driver.
> 
> Inspired by a change on nvidia's git server:
>   http://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=commit;h=266d1b7397284505e55d06254b497cb32be07b69
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> This takes Felipe Balbi's suggestion of making the overflow
> error non-fatal.

the WARN() was very nice idea, I was thinking of just returning an error
to the client, but the adition of WARN() will make it really bold ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110816/dc045f92/attachment.sig>
