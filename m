From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Sun, 25 Nov 2012 18:02:45 -0200
Subject: DMABUF V4L2 patches got merged
Message-ID: <20121125180245.658e68a7@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today, I finally merged the DMABUF V4L2 patches from Tomasz.

The DMABUF allows replacing the old V4L2 Overlay method by something more
robust and safer.

It was a long road to get them ready for their upstream inclusion, and to
be able to test on both embedded and personal computers.

Along this weekend, I was able to test it using 4 different test scenarios:

	- vivi + s5p-tv;
	- uvcvideo + fimc (m2m) + s5p-tv;
	- s5k4ecgx + fimc (m2m) + s5p-tv;
	- uvcvideo + i915.

The first 3 tests ran on a Samsung Origen Rev. A board; the 4th one on a
notebook, with a Sandy Bridge i5core processor with GPU, and an embedded
UVC camera.

While testing the s5k4ecgx sensor driver, I also added support for multiplane
at libv4l, via its plugin interface:

	http://git.linuxtv.org/v4l-utils.git/commit/ced1be346fe4f61c864cba9d81f66089d4e32a56	

Such tests wouldn't be possible without the help of Linaro and Samsung,
with donated me some hardware for the tests, and Ideas on Board for making
uvcvideo + i915 driver to work especially for this test.

Thank you all for your support!

In particular, Sylwester helped me a lot to fix several non-related issues with
the Origen board, that was not running with an upstream Kernel.

There are a number of patches required to make the Origen board to work with an 
Upstream Kernel. Also, its sensor driver (s5k4ecgx) was not submitted upstream 
yet. In order to help others that may need to do similar tests, I added the 
needed patches on my experimental tree, at branch origen+dmabuf:

	http://git.linuxtv.org/mchehab/experimental.git/shortlog/refs/heads/origen%2Bdmabuf

Still missing there are the wireless/bluetooth support. It seems that there are
some patches for it already, but they aren't submitted upstream, nor I didn't
test they.

I expect that Linaro and Samsung will be able to submit real soon the pending 
patches needed by Origen in time for its addition on 3.8.

Thank you all!
Mauro
