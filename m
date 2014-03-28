From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 08:49:00 +0100
Subject: [PATCH] i2c: mv64xxx: Fix reset controller handling
In-Reply-To: <1394449930-29696-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394449930-29696-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140328074900.GC2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 12:12:10PM +0100, Maxime Ripard wrote:
> The reset framework recently gained optional stubs when CONFIG_RESET_CONTROLLER
> is not selected. It also introduced a function reset_get_optional, that is also
> dummy-defined whenever the framework isn't enabled, for drivers that needs an
> optional reset controller.
> 
> Switch to this function, since the mv64xxx driver is in this case. This also
> fixes a compilation breakage whenever the reset framework wasn't selected:
> 
> drivers/i2c/busses/i2c-mv64xxx.c:771:2: error: implicit declaration of function 'devm_reset_control_get'
> 
> While we're at it, remove the redundant test on dev.of_node surrounding the
> calls to reset framework functions, since it will either be a valid pointer, an
> error pointer in the case where we called reset_get_optional without an of_node
> pointer or if it failed, or NULL if we're not loaded through DT.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/81cece5a/attachment.sig>
