From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 13 Jul 2013 18:38:47 +0100
Subject: DT binding review for Armada display subsystem
In-Reply-To: <CAMLZHHSrX2T+pU3RosmjS3EggV3mX_J8D2OJD52sww_n6Y7B+A@mail.gmail.com>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
 <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
 <20130713103516.38a55b0b@armhf>
 <CAMLZHHSrX2T+pU3RosmjS3EggV3mX_J8D2OJD52sww_n6Y7B+A@mail.gmail.com>
Message-ID: <20130713173847.GN24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 13, 2013 at 08:25:15AM -0600, Daniel Drake wrote:
> I guess the IRE falls into the same category as the DCON - we won't
> implement it for now, but knowing where it might fit in is useful.

I don't see much need at the moment for IRE.  IRE isn't going to be
useful for general graphics rotation as it only supports up to 16bpp
RGB.

It looks to me like this module was designed to rotate YUV/camera
images.  If we wanted to rotate a video image, then it would probably
be more efficient to use this, but it will cause a conversion of the
image format in doing so.
