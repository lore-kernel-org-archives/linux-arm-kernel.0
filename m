From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 20 Nov 2013 04:45:40 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <20131120002007.GR16735@n2100.arm.linux.org.uk>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
 <20131120002007.GR16735@n2100.arm.linux.org.uk>
Message-ID: <CALT56yP-LsO_8qgpa3R6JQSWW2pGkNWBUtab8L2hQnC5UdoKvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 4:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Also note that we _do_ have sa11x0 platforms which request their GPIOs
> in their arch_initcall callback, so the sa11x0 GPIO driver better be
> around at that point otherwise things *will* fail.

Which ones if you have them in your mind?

> I suspect that means the SA11x0 GPIO driver must be initialised early.

Anyway in these patches gpio-sa1100 driver is registered at postcore
initcall, so gpios should
be available before arch_initcall functions.


-- 
With best wishes
Dmitry
