From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Sep 2012 18:26:57 +0100
Subject: [BUG] Deferred probing in driver model is racy, resulting in
 lost probes
In-Reply-To: <CAGhQ9VzJtx3MJF1wdJd8hv7Hp4T0YJK=vNbJWGj_W7X+mLy-xQ@mail.gmail.com>
References: <20120818145856.GP18957@n2100.arm.linux.org.uk>
 <CACVXFVPahbFVEP4p2Z9-TvjQ52tUCMuDeLx0X6GP5t0h5gEV8g@mail.gmail.com>
 <20120916082510.GN12245@n2100.arm.linux.org.uk>
 <CACVXFVOZ=4HFAy38q_8ZUjOPffcv_mMTi7KCdh3HcX=MCLw5SQ@mail.gmail.com>
 <20120926200833.GA14340@kroah.com>
 <20120926202321.GD30938@n2100.arm.linux.org.uk>
 <CACVXFVPnpQ6yHiDaoo_CPG7oSEq+ZzxpmTgQv55-tRRyaavDfA@mail.gmail.com>
 <20120927135809.GE14358@n2100.arm.linux.org.uk>
 <20120927140300.GF14358@n2100.arm.linux.org.uk>
 <CAGhQ9VzJtx3MJF1wdJd8hv7Hp4T0YJK=vNbJWGj_W7X+mLy-xQ@mail.gmail.com>
Message-ID: <20120927172656.GE4428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 07:22:38PM +0200, Joachim Eastwood wrote:

> [   13.140000] sysfs: cannot create duplicate filename
> '/devices/platform/ssc.0/atmel-ssc-dai.0'
> [   13.140000] Modules linked in: snd_soc_mpa1600_wm8776(+)

Oh, dear.  This is probably a genuine bug, triggered by but not really
related to deferred probing.
