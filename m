From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 10 Apr 2011 09:58:34 +0200
Subject: [PATCH 2/3] Use gpio_set_value_cansleep() in corgi_lcd.c
In-Reply-To: <BANLkTimtLsF_fQQbfxRQZ6ToBWj5HvGm6A@mail.gmail.com>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
	<1301708597-7413-2-git-send-email-marek.vasut@gmail.com>
	<BANLkTimtLsF_fQQbfxRQZ6ToBWj5HvGm6A@mail.gmail.com>
Message-ID: <20110410075834.GA2798@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2011-04-04 18:45:46, Eric Miao wrote:
> Personally, I don't quite like the idea of an explicit _cansleep() version,
> which is just confusing. A programmer shouldn't be aware of which
> version to use.
> 
> David, you have any justification?

Whether it is possible to sleep in given context  is not  something
that  can be detected automatically in general case; so two different
functions are needed.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
