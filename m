From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Apr 2011 13:06:34 +0100
Subject: [PATCH 2/3] Use gpio_set_value_cansleep() in corgi_lcd.c
In-Reply-To: <BANLkTimtLsF_fQQbfxRQZ6ToBWj5HvGm6A@mail.gmail.com>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
	<1301708597-7413-2-git-send-email-marek.vasut@gmail.com>
	<BANLkTimtLsF_fQQbfxRQZ6ToBWj5HvGm6A@mail.gmail.com>
Message-ID: <20110404120633.GB26494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2011 at 06:45:46PM +0800, Eric Miao wrote:
> Personally, I don't quite like the idea of an explicit _cansleep() version,
> which is just confusing. A programmer shouldn't be aware of which
> version to use.

When working in interrupt context you need to pay attention to this
stuff; personally I'd prefer an explict IRQ safe version but YMMV.  The
only use the code makes of this is to generate warnings to make problems
easier to diagnose.

> David, you have any justification?

Sadly David passed away recently.
