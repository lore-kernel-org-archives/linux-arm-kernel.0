From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 8 Jan 2014 11:04:13 +0200
Subject: [PATCH 0/2] video: mxsfb: fix broken videomode selection
In-Reply-To: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
References: <1389014278-4903-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <52CD148D.7060107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-06 15:17, Lothar Wa?mann wrote:
> The first patch in this set converts some messages that are printed
> in case of errors to be error messages rather than debug messages.
> 
> The second patch fixes a bug in the video selection code that
> incorrectly OR's together the 'pixelclk-active' and 'de-active'
> flags from all possible video modes specified in DT into one flag.
> 
> The current code does not allow selecting one specific mode from a
> list of video modes, but always uses the last one of the video modes
> listed in the DT.
> 
> 
> Since all current dts files only have one entry in their
> 'display-timings' node, this bug was not apparent and the fix does not
> change the driver's behaviour for the current users.
> 
>  b/drivers/video/mxsfb.c |    6 +--
>  drivers/video/mxsfb.c   |  120 +++++++++++++++++++++++++++++-----------------------------------------
>  2 files changed, 53 insertions(+), 73 deletions(-)
> 

Thanks, queued for 3.14.

Your diffstat above looks a bit funny. Where did that "b/" come from?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/44134686/attachment.sig>
