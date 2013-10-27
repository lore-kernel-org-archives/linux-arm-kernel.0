From: sre@ring0.de (Sebastian Reichel)
Date: Sun, 27 Oct 2013 17:31:27 +0100
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <20131027122347.GE15154@atomide.com>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
 <20131027114753.GB14901@amd.pavel.ucw.cz>
 <20131027122347.GE15154@atomide.com>
Message-ID: <20131027163126.GA25517@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 05:23:48AM -0700, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [131027 04:48]:
> > > > > +#if IS_ENABLED(CONFIG_OF)
> > > > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> > > 
> > > I have been told for other drivers, that IS_ENABLED() is
> > > the prefered way to check for configuration these days.
> > 
> > CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.
> 
> Good point. Looks like there's IS_BUILTIN that's for boolean options.

Using IS_ENABLED for boolean options is supposed to be supported
according to the comment above IS_BUILTIN:

/*
 * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
 * otherwise. For boolean options, this is equivalent to
 * IS_ENABLED(CONFIG_FOO).
 */
#define IS_BUILTIN(option) config_enabled(option)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131027/708acccd/attachment.sig>
