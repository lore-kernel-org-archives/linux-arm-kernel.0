From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 May 2013 23:36:14 +0800
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
In-Reply-To: <20130527121658.GA3660@sirena.org.uk>
References: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
 <20130516093846.GA2927@katana>
 <CAGsJ_4zVOF8-g=emEGgP3atxkWdxMaQQiVZrZkht_WueTriSnw@mail.gmail.com>
 <20130525201032.GD32043@sirena.org.uk>
 <CAGsJ_4y6SY6nNkbW+Yh8jx0WB4Pi9MO1W3xVZcrQcedGeD5ogQ@mail.gmail.com>
 <20130527121658.GA3660@sirena.org.uk>
Message-ID: <CAGsJ_4w867BhFvVze5BNaYheW75pMcOGhscz3wSZiia-neP59w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/27 Mark Brown <broonie@kernel.org>:
> On Mon, May 27, 2013 at 09:54:56AM +0800, Barry Song wrote:
>
>> Mark, the case is not that deferred probing is slow or not. deferred
>> probing is pretty good.
>> the case is that we want to i2c and media connected with i2c probed
>> earlier than other devices.
>> in auto infotainment devices, we actually do some hacking in kernel
>> that makes rear view work earlier than other device driver
>> initialization with a kernel thread which take care of backing-car
>> policy not only mechanism. that means, we make camera work to see
>> backview image even earlier than other drivers' initialization.
>> we don't want media deferred to wait for i2c. we want make some early
>> jobs ready earlier.
>
> So this change makes no practical difference in mainline and exists to
> support out of tree hacks for performance?  It doesn't seem like that
> big a patch to carry along with the out of tree stuff...

yes. but i don't think we are easy to make those out-of-mainline hacks
 be in mainline. but this patch is both ok to mainline and local tree.
making local tree and mainline same as many as possible decreases our
maintaince efforts totally.

-barry
