From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Sep 2014 17:49:34 -0500
Subject: [PATCH] i2c: qup: Fix order of runtime pm initialization
In-Reply-To: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
References: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
Message-ID: <20140929224934.GB21681@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 05:00:51PM -0500, Andy Gross wrote:
> The runtime pm calls need to be done before populating the children via the
> i2c_add_adapter call.  If this is not done, a child can run into issues trying
> to do i2c read/writes due to the pm_runtime_sync failing.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/bbd394d1/attachment.sig>
