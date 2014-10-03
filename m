From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 03:21:38 +0200
Subject: [PATCH] i2c: qup: Fix order of runtime pm initialization
In-Reply-To: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
References: <1412028051-21774-1-git-send-email-agross@codeaurora.org>
Message-ID: <20141003012138.GH1323@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 05:00:51PM -0500, Andy Gross wrote:
> The runtime pm calls need to be done before populating the children via the
> i2c_add_adapter call.  If this is not done, a child can run into issues trying
> to do i2c read/writes due to the pm_runtime_sync failing.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/ee5b9e52/attachment.sig>
