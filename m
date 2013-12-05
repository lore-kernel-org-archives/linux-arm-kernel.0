From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Dec 2013 00:09:28 +0000
Subject: [PATCH 1/2] regulator: gpio-regulator: Add required
 regulator-type property
In-Reply-To: <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131205000928.GI29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 04:44:52PM +0100, Laurent Pinchart wrote:
> The gpio-regulator driver requires the regulator-type property to be
> present. Document it as required in the DT bindings.

It does?  That seems needless.  It should just default to voltage and
provide a way override to current, though frankly I'd be astonished to
see a GPIO controlled current regulator at all so I'm not sure I'd even
bother writing the code for that until someone needs it.  As it is this
will most likely just be noise in the DT files and wasted cycles parsing
the property.

Please CC maintainers...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131205/bc4bd07d/attachment.sig>
