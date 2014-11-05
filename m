From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 5 Nov 2014 17:08:15 +0200
Subject: [PATCH 11/15] [media] Deprecate v4l2_mbus_pixelcode
In-Reply-To: <1415094910-15899-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415094910-15899-12-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141105150814.GT3136@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Tue, Nov 04, 2014 at 10:55:06AM +0100, Boris Brezillon wrote:
> The v4l2_mbus_pixelcode enum (or its values) should be replaced by the
> media_bus_format enum.
> Keep this enum in v4l2-mediabus.h and create a new header containing
> the v4l2_mbus_framefmt struct definition (which is not deprecated) so
> that we can add a #warning statement in v4l2-mediabus.h and hopefully
> encourage users to move to the new definitions.
> 
> Replace inclusion of v4l2-mediabus.h with v4l2-mbus.h in all common headers
> and update the documentation Makefile to parse v4l2-mbus.h instead of
> v4l2-mediabus.h.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  Documentation/DocBook/media/Makefile |  2 +-
>  include/media/v4l2-mediabus.h        |  2 +-
>  include/uapi/linux/Kbuild            |  1 +
>  include/uapi/linux/v4l2-mbus.h       | 35 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/v4l2-mediabus.h   | 26 ++++----------------------

I would keep the original file name, even if the compatibility definitions
are there. I don't see any harm in having them around as well.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
