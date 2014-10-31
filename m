From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Oct 2014 21:57:56 +0100
Subject: [PATCH 1/2] ARM: at91: rm9200 add system timer resources to
 watchdog
In-Reply-To: <3170633.12AsIiHlY5@wuerfel>
References: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com>
 <3170633.12AsIiHlY5@wuerfel>
Message-ID: <20141031205756.GB11327@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/10/2014 at 21:50:05 +0100, Arnd Bergmann wrote :
> On Friday 31 October 2014 21:45:58 Alexandre Belloni wrote:
> > To be able to make the watchdog driver independent from the mach/ includes, pass
> > the system timer register space as a resource.
> > 
> > Also, change the name to avoid conflicting with the at91sam9 watchdog driver.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> 
> Doing this change as a separate patch breaks bisection because now the device
> name no longer matches untile the other patch is applied too.
> 

Yeah, I was not sure how important that was as there is no user of the
watchdog in the kernel. My thinking was that both patch can then go
through different trees.

I can definitely squash them.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
