From: rabin@rab.in (Rabin Vincent)
Date: Thu, 24 Dec 2015 20:20:48 +0100
Subject: [PATCH V7 04/24] coresight: moving PM runtime operations to core
 framework
In-Reply-To: <CANLsYkzgMq1caiE+wA2RRBpe4Bg14Fy7Eu8CnRkrhYmNg7j1Bg@mail.gmail.com>
References: <1450472361-426-1-git-send-email-mathieu.poirier@linaro.org>
 <1450472361-426-5-git-send-email-mathieu.poirier@linaro.org>
 <20151219171342.GA2437@debian>
 <CANLsYkzgMq1caiE+wA2RRBpe4Bg14Fy7Eu8CnRkrhYmNg7j1Bg@mail.gmail.com>
Message-ID: <20151224192047.GA2914@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 09:27:28AM -0700, Mathieu Poirier wrote:
> On 19 December 2015 at 10:13, Rabin Vincent <rabin@rab.in> wrote:
> > It should presumably be using pm_runtime_put() instead.
> 
> That's a first - what platform did you test on?  If I send you fixes
> will you be able to help me with the verification?

I tested on a Pandaboard (OMAP4), with [1] applied,  but you're likely
to see this on any platform if you have CONFIG_PM=y and
CONFIG_DEBUG_ATOMIC_SLEEP=y.

[1] https://github.com/rabinv/linux/commit/omap-coresight
