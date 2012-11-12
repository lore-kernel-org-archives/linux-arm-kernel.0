From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 19:27:27 +0000
Subject: [PATCH] ARM: add get_user() support for 8 byte types
In-Reply-To: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
References: <1352495853-9790-1-git-send-email-rob.clark@linaro.org>
Message-ID: <20121112192727.GB28341@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 03:17:33PM -0600, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> A new atomic modeset/pageflip ioctl being developed in DRM requires
> get_user() to work for 64bit types (in addition to just put_user()).

NAK.

(I did write a better email explaining all the ins and outs of why this
won't work and why 64-bit get_user isn't possible, but my editor crapped
out and lost all that well written message; I don't fancy typing it all
out again.)

Nevertheless,
int test_ptr(unsigned int **v, unsigned int **p)
{
        return get_user(*v, p);
}

produces a warning, and you can't get away from that if you stick 64-bit
support into get_user().

Sorry, 64-bit get_user() is a no-no.
