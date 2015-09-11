From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:08:24 +0100
Subject: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
In-Reply-To: <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150911120824.GP12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:29PM +0200, Tomeu Vizoso wrote:
> Walks the OF tree up and finds the closest ancestor that has a struct
> device associated with it, probing it if isn't bound to a driver yet.

> The above should ensure that the dependency represented by the passed OF
> node is available, because probing a device should cause its descendants
> to be probed as well (when they get registered).

I'm still not seeing how this works for MFDs where the MFD binding is
present directly in DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/db4164d4/attachment.sig>
