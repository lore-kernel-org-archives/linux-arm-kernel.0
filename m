From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 6 Oct 2010 18:52:47 +0100
Subject: [PATCH] Input: Make ADS7846 independent on regulator
In-Reply-To: <AANLkTindRMOmo8CrFuUsWqNRn6CZVKOMQZS2LXJ63=YC@mail.gmail.com>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com>
	<AANLkTindRMOmo8CrFuUsWqNRn6CZVKOMQZS2LXJ63=YC@mail.gmail.com>
Message-ID: <20101006175247.GB2874@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 07:16:05PM +0200, Linus Walleij wrote:
> 2010/7/31 Marek Vasut <marek.vasut@gmail.com>:

> > +#ifdef CONFIG_REGULATOR

> Skip the #ifdef, if the regulators are configured out, there will be
> a stub providing NULL for all get_regulator() calls anyway.

While ifdefs on CONFIG_REGULATOR should indeed be skipped I'd not expect
the stubs to be returning NULL for anything (but then as discussed
elsewhere this whole approach of doing everything in the drivers is a
poor one).
