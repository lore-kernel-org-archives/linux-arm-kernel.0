From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 5 Nov 2014 17:22:52 +0200
Subject: [PATCH 11/15] [media] Deprecate v4l2_mbus_pixelcode
In-Reply-To: <20141105161538.7a1686d5@bbrezillon>
References: <1415094910-15899-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415094910-15899-12-git-send-email-boris.brezillon@free-electrons.com>
 <20141105150814.GT3136@valkosipuli.retiisi.org.uk>
 <20141105161538.7a1686d5@bbrezillon>
Message-ID: <20141105152252.GV3136@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Wed, Nov 05, 2014 at 04:15:38PM +0100, Boris Brezillon wrote:
> On Wed, 5 Nov 2014 17:08:15 +0200
> Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > I would keep the original file name, even if the compatibility definitions
> > are there. I don't see any harm in having them around as well.
> > 
> 
> That's the part I was not sure about.
> The goal of this patch (and the following ones) is to deprecate
> v4l2_mbus_pixelcode enum and its values by adding a #warning when
> v4l2-mediabus.h file is included, thus encouraging people to use new
> definitions.
> 
> Do you see another solution to generate such warnings at compilation
> time ?

Do you think we need a warning? In a general case we can't start renaming
interface headers once the preferred interface changes, albeit in this case
it would be a possibility.

The presence of the formats defined from now on only in the new definitions
should be good enough. There are many cases such as this in the V4L2 and
other APIs.

I wonder what others think.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
