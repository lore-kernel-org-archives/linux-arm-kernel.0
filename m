From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 20:53:06 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703184626.GC21086@arm.com>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <4840595.cpHbY6hJKL@wuerfel> <20140703184626.GC21086@arm.com>
Message-ID: <15521199.3bNj4354Mf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 19:46:26 Will Deacon wrote:
> 
> My initial objections when this was posted were primarily driven by not
> knowing when we can safely remove a feature. The default position with the
> arm64 kernel was not to emulate anything, then we would see whether we ever
> had valid users of these features and could consider them on a case-by-case
> basis. I still think that was the right thing to do.
> 
> However, saying "as long as anybody is using it" is really saying "as long
> as anybody is complaining about it being missing". Once we've added
> emulation, nobody will ever complain about it being missing, because it
> won't be missing. Do you have any ideas about phasing out emulation code
> when you don't know if it's used or not?

Not a lot of good ideas. One thing that can be done is to move the Kconfig
option for enabling the emulation under 'CONFIG_EXPERT' in a couple of years,
possibly renaming it a few times every other year so people that blindly
reuse their .config files will have it disabled again. If we do that, there
should of course be a message printed that references a description for
how to turn it back on and report that you are still using it.

It's certainly a very lengthy process. Just look at how long NWFPE has
been in the kernel after it has become obsolete.

	Arnd
