From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 8 Jan 2011 20:52:59 +0100
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
Message-ID: <AANLkTi=uw2sxizgDBSnDQVMaokikirDQgxt1w6sP4C05@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 7, 2011 at 11:38 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:
> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
> raster engine needed for framebuffer support.
>
> This allows the EDB93xx boards with those processors to use the framebuffer
> driver.
>
> Tested on an EDB9307A with the following kernel parameters:
> ? ? ? ?video=640x480-16 at 60
> ? ? ? ?video=1024x768-16 at 60
>
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

The code looks good, but there are hardware bugs in the EP93XX that
make the screen image jump a few pixels to the right once every few
seconds.  We found that 800x600-16 and 1024x768-8 were the highest
modes that are stable.
Did you find 1024x768-16 to be stable, say when running X and moving a
window? The effect was most visible on a phosphor CRT, less noticeable
on an LCD.

    M
