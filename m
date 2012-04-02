From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 17:30:43 +0100
Subject: [RFC] pinctrl: Replace list_groups() with get_groups_count()
In-Reply-To: <4F74A05E.7050803@wwwdotorg.org>
References: <CAOh2x==LTHPM+O9LXVFVdX2NfzKs2bttiYLm8VcL6qLXKrUMBg@mail.gmail.com>
 <4F749B58.4070608@wwwdotorg.org>
 <CAOh2x==mGDZRoxdbuvbhKtfoxiEDVb+7vdfBEYD=u+DdMCYVhw@mail.gmail.com>
 <4F74A05E.7050803@wwwdotorg.org>
Message-ID: <20120402163043.GB29808@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:48:14AM -0600, Stephen Warren wrote:
> On 03/29/2012 11:31 AM, viresh kumar wrote:

> > Which other subsystems have such stuff?

> For example. include/linux/regulator/driver.h struct regulator_ops field
> list_voltage().

The reason regulator does this for list voltage is because we
idiomatically have gaps in the space of selectors as they should
normally map directly onto register values but sometimes some of the
register values are not specified so we need to skip them.  This can
happen both due to chip limitations or due to constraints imposed by
the system.
