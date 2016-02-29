From: dvhart@infradead.org (Darren Hart)
Date: Mon, 29 Feb 2016 15:07:11 -0800
Subject: [PATCH] platform/x86: never 'select DMI' from a driver
In-Reply-To: <CALCETrVxj0rt=5k7-tfTqwWOfshkkQkajQdhF6OE1we1h_2trw@mail.gmail.com>
References: <1456748014-358588-1-git-send-email-arnd@arndb.de>
 <CALCETrVxj0rt=5k7-tfTqwWOfshkkQkajQdhF6OE1we1h_2trw@mail.gmail.com>
Message-ID: <20160229230711.GH7499@dvhart-mobl5.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 07:46:58AM -0800, Andy Lutomirski wrote:
> On Mon, Feb 29, 2016 at 4:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > CONFIG_DMI is a user-selectable Kconfig symbol that some drivers
> > depend on. As part of a recent patch, other drivers started
> > adding a 'select' for the same symbol, which now causes
> > a recursive dependency:
> 
> Darren, it may make sense for you to fold the DELL_LAPTOP change in.

Andy, I didn't quite follow you. Are you referring to this patch from Arnd, or
from the dell-smbios series from Micha??

I'm planning on merging both (Micha?'s is pending a v5).

-- 
Darren Hart
Intel Open Source Technology Center
