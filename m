From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Sep 2011 09:35:04 +0200
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110919191617.GB16381@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<20110919184027.GZ16381@n2100.arm.linux.org.uk>
	<20110919184230.GF540@opensource.wolfsonmicro.com>
	<20110919185809.GA16381@n2100.arm.linux.org.uk>
	<20110919190602.GG540@opensource.wolfsonmicro.com>
	<20110919191617.GB16381@n2100.arm.linux.org.uk>
Message-ID: <20110920073504.GI23628@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 08:16:17PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 19, 2011 at 08:06:03PM +0100, Mark Brown wrote:
> > Yeah, it's a shame it doesn't include the disambiguated short ID in the
> > standard git log output (which is what I always grep if I'm trying to
> > search commit messages).  I've never seen a way to tell git to use %H
> > instead of %h there by default that doesn't require me to start copying
> > scripts or whatever between machines all the time.
> 
> I'm in two minds over this:
> 
> [format]
>         pretty = %h %s
> 
> which I currently have in my ~/.gitconfig file.  It means that I always
> get git log output as:
> 
> 38c0a0c Merge branches 'apei', 'bz-13195' and 'doc' into acpi
> b6fd41e Linux 3.1-rc6
> 8cb3ed17 Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux4c75278 Merge branch 'fixes' of git://git.linaro.org/people/arnd/arm-soc
> 14d01ff ioctl: register LTTng ioctl
> 
> rather than the more usual medium-pretty output.  I can get that by
> using git log --pretty=medium.  The alternative to that is to use
> shell aliases to pass the --pretty= argument for a gitslog alias -
> or I believe you can create git command aliases in the ~/.gitconfig file.
> (Never tried it yet, something I need to look at.)
I did:

	git config --global alias.lg "log --pretty=oneline --abbrev-commit"
	git config --global alias.one "show -s --pretty='format:%h (%s)"

which results in

	[alias]
		lg = log --pretty=oneline --abbrev-commit
		one = show -s --pretty='format:%h (%s)'

and makes available the commands

	git lg

(for summary logging) and

	git one

(to format a commit id for use in another commit message).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
