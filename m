From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Dec 2014 07:22:24 -0500
Subject: How much flash space should I reserve for device tree blobs?
In-Reply-To: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
References: <CAFZh4h_74LY=w7gV=zNAC0ssRFgrh1DduPmZ2c+HenbztRRc-A@mail.gmail.com>
Message-ID: <20141216122224.GG967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Brian,

+Arnd, Olof.

On Mon, Dec 15, 2014 at 03:33:50PM -0500, Brian Hutchinson wrote:
> Reflecting back on the famous quote of "Nobody needs more than 640K",
> how much space should I reserve in flash to 'future proof' my MTD map
> in regards to dtb's?
> 
> Looking at the current flavors of dtb's built in a recent mainline
> kernel, the biggest one I see is 66K.
> 
> How big do you all see these getting?  I know, it's probably a loaded
> question.  Would just like to bounce this off the list as a sanity
> check ... measure twice cut once kind of thing.

There's probably better folks to answer this than me (former powerpc
folks, eg Arnd, Olof), but since I've had to consider it as well, I'll
tell you my thoughts.

The biggest unknown is the addition of binary blobs.  If those are a
consideration for your board(s), then you need to reserve quite a bit
more space.

For example, a binding update could start including the firmware for an
SD wifi card.  However, in the interest of retaining backwards
compatibility, Linux would still be able to load from /lib/firmware.
So, if you couldn't update your dtb, you'd still have a working wifi
card.

If you aren't concerned about binary blobs, then I'd say you're fine
with 128k or so.

Most of the scenarios I had were with 2MB NOR flash.  barebox is usually
in the range of 200k, and there isn't enough room left for the kernel,
so I had plenty for the environment and the dtb.

hth,

Jason.
