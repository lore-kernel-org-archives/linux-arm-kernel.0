From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 28 Apr 2014 09:07:28 +0200
Subject: [PATCH RFC 6/8] component: remove old add_components method
In-Reply-To: <E1WeBbp-0002Gs-Ju@rmk-PC.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <E1WeBbp-0002Gs-Ju@rmk-PC.arm.linux.org.uk>
Message-ID: <20140428070727.GC19455@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 12:02:13AM +0100, Russell King wrote:
> Now that drivers create an array of component matches at probe time, we
> can retire the old methods.  This involves removing the add_components
> master method, and removing component_master_add_child() from public
> view.  We also remove component_add_master() as that interface is no
> longer useful.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/base/component.c  | 21 +--------------------
>  include/linux/component.h |  5 -----
>  2 files changed, 1 insertion(+), 25 deletions(-)

I'm wondering if there may be an advantage to keeping both interfaces.
Even if currently what all implementations do is essentially creating
the match table at probe time there may be use-cases where that doesn't
work so well.

There's also some elegance to the .add_components() interface. I have a
set of patches to convert Tegra DRM to use the component framework and
it works out rather nicely. I'm sure I can get it to work with your
proposed match array changes too, but it seems like it will require more
code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/ce62653f/attachment.sig>
