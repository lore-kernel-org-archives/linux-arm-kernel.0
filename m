From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 3 Mar 2015 10:45:41 +0100
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <CAL_Jsq+tP6wBcDti7x-B6ar8esE=65Ymg_CKANeOKSe=yYhNnw@mail.gmail.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <54EB4E9B.6010001@free-electrons.com>
 <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
 <20150227174851.390d9f58@free-electrons.com>
 <CAL_Jsq+tP6wBcDti7x-B6ar8esE=65Ymg_CKANeOKSe=yYhNnw@mail.gmail.com>
Message-ID: <20150303104541.345608b4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob Herring,

On Fri, 27 Feb 2015 11:42:43 -0600, Rob Herring wrote:

> > It is worth mentioning that this also happens with
> >
> >      stdout-path = "uart0:115200n8";
> >
> > which was explicitly suggested by Mark in his e-mail. uart0 is an alias
> > to the proper DT node, since stdout-path = &uart0; works almost fine.
> 
> Mark forgot the '&'. So does 'stdout-path = "&uart0:115200n8";' work?

Nah, there is really no '&' needed, Mark was right. What was wrong in
my setup was that uart0 was a *label* for the serial port DT node, and
not an alias. Once I created an alias 'serial0' for '&uart0', things
started working all right.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
