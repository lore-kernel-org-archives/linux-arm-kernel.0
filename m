From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 09:10:31 +0200
Subject: [PATCH RFC 7/8] component: move check for unbound master into
 try_to_bring_up_masters()
In-Reply-To: <E1WeBbu-0002Gy-NZ@rmk-PC.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBbu-0002Gy-NZ@rmk-PC.arm.linux.org.uk>
Message-ID: <20140428071030.GD19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 12:02:18AM +0100, Russell King wrote:
> Clean up the code a little; we don't need to check that the master is
> unbound for every invocation of try_to_bring_up_master(), so let's move
> it to where it's really needed - try_to_bring_up_masters(), where we may
> encounter already bound masters.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/component.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/60a0e5e5/attachment.sig>
