From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Dec 2014 16:52:30 +0000
Subject: [RFC 02/15] drivers/base: add restrack framework
In-Reply-To: <1418226513-14105-3-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-3-git-send-email-a.hajda@samsung.com>
Message-ID: <20141212165230.GP11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 04:48:20PM +0100, Andrzej Hajda wrote:
> restrack framework allows tracking presence of resources with dynamic life
> time. Typical example of such resources are all resources provided by device

I don't know about anyone else but I'm having a hard time reading the
restrack name, it looks like a misspelling of restack to me.

At a high level my biggest questions here are the relationship between
this and the component code and usability.  The usability concern I have
is that I see no diagnostics or trace here at all.  This means that if a
user looks at their system, sees that the device model claims the driver
for a device bound to the device but can't see any sign of the device
doing anything they don't have any way of telling why that is other than
to look in the driver code, see what resources it was trying to depend
on and then go back to the running system to try to understand which of
those resources hasn't appeared.

> +int restrack_up(unsigned long type, const void *id, void *data)

> +int restrack_down(unsigned long type, const void *id, void *data)

Again I'm not sure that the up and down naming is meaningful in the
context of this interface.

> +static void restrack_itb_cb(struct track_block *itb, void *data, bool on)
> +{

itb_cb?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141212/10951c43/attachment.sig>
