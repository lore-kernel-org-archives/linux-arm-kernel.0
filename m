From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 14:12:01 +0100
Subject: [PATCH] pinctrl: at91: move lock/unlock_as_irq calls into
 request/release resources methods
In-Reply-To: <95765FA2-E9BF-4A66-B46D-2491869B0A14@jcrosoft.com>
References: <1423419822-6258-1-git-send-email-boris.brezillon@free-electrons.com>
 <BC36A77B-9986-495E-8F86-C80E9D0F0C63@jcrosoft.com>
 <95765FA2-E9BF-4A66-B46D-2491869B0A14@jcrosoft.com>
Message-ID: <20150226141201.670e6e18@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Feb 2015 15:50:36 +0800
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> 
> > On Feb 9, 2015, at 10:50 PM, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > 
> > 
> >> On Feb 9, 2015, at 2:23 AM, Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >> 
> >> The gpiochip_lock_as_irq call can fail and return an error, while the
> >> irq_startup is not expected to fail (returns an unsigned int which is not
> >> checked by irq core code).
> >> 
> >> irq_request/release_resources functions have been created to address this
> >> problem.
> >> 
> >> Move gpiochip_lock/unlock_as_irq calls into
> >> irq_request/release_resources functions to prevent using a gpio as an irq
> >> if the gpiochip_lock_as_irq call failed.
> >> 
> >> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> >> ?
> > 
> > I?m travelling will take a look end of the week
> 
> just get back from travelling will take a look after Chinese new year
> as all my hw are at the office

Ping



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
