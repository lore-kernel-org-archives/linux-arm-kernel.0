From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 11:10:42 +0100
Subject: [PATCH] ASoC: samsung: Allow setting OP_CLK of the IIS Multi
 Audio Interface
In-Reply-To: <537B1BF0.8060302@samsung.com>
References: <1400520638-6907-1-git-send-email-s.nawrocki@samsung.com>
 <537AE4C1.7050703@linaro.org> <537B1BF0.8060302@samsung.com>
Message-ID: <20140520101042.GK12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:10:08AM +0200, Sylwester Nawrocki wrote:

> So how do you think this should be addressed ? Isn't it better to give
> options to the machine drivers to alter these clock settings, rather than
> hard coding it in the I2S driver ? Let's not forget it covers multiple 
> Samsung SoC series.

Yes, it's better to make it controllable - ideally this could be moved
into the clock API but for ASoC level stuff set_sysclk() with a sensible
default is how it's supposed to be done.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/b741032e/attachment.sig>
