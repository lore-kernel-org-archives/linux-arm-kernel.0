From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Mon, 10 Oct 2016 10:48:59 +0200
Subject: camera on n900, v4.8
In-Reply-To: <20161005190340.GA25755@amd>
References: <20161005190340.GA25755@amd>
Message-ID: <20161010084859.GD4467@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 October 2016 21:03:41 Pavel Machek wrote:
> Hi!
> 
> Camera has some non-trivial dependencies on N900; it seems to rely on
> gpio-switch.c, for example. I'll try to strip the diff further, but in
> the meantime, here's the version I'm working with.
> 
> 									Pavel
> 
> 

With "Camera" do you mean some Maemo userspace application? Because I
think that nobody else could depends on gpio-switch kernel driver.

Anyway, it should be easy to rewrite such gpio-switch application to use
either input kernel events (from /dev/input/something) or directly check
gpio state via /sys/class/gpio/.

IIRC Maemo's Camera needed gpio-switch for testing if back camera cover
is open or closed and for checking when camera push button pressed and
released.

-- 
Pali Roh?r
pali.rohar at gmail.com
