From: broonie@kernel.org (Mark Brown)
Date: Mon, 3 Feb 2014 12:46:59 +0000
Subject: [PATCH v5 00/23]
In-Reply-To: <20140202190606.6fa193ce@armhf>
References: <cover.1390986082.git.moinejf@free.fr>
 <20140202124358.GD26684@n2100.arm.linux.org.uk>
 <20140202190606.6fa193ce@armhf>
Message-ID: <20140203124659.GW22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 02, 2014 at 07:06:06PM +0100, Jean-Francois Moine wrote:

> - the .of_match_table is not needed because the i2c client is created by
>   the i2c subsystem from the 'reg' in the DT,

It's generally better to have an explict set of OF IDs even if the
default does work - matching purely on the device name does work almost
all the time but there are collisions out there with different
manufacturers using the same prefix for their chips (the example I
always trot out is that both Wolfson and Wondermedia use "wm").
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140203/201b93b6/attachment.sig>
