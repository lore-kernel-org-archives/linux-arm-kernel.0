From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 04 Apr 2016 12:37:07 +0200
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAJ+vNU0iKSXrKmA6jzdw5R5K3TnR3qftVn-8Ou5chHdz5aTpTA@mail.gmail.com>
 (Tim Harvey's message of "Thu, 31 Mar 2016 09:19:31 -0700")
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
 <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
 <CAJ+vNU1_YqvWQkmuDB7r8z77iZJS6pP4Mr+j9yW4sFLAeJXQDw@mail.gmail.com>
 <CAOMZO5A2osG3=mTaCayYfMokUj-vT+Udq9ckq45b1yaUP9Tn3g@mail.gmail.com>
 <CAJ+vNU2ST=XG5H04-OCwpHgcvkoXOQw8F3MjXhJmWhBUbxWE-g@mail.gmail.com>
 <1459241739.2565.9.camel@pengutronix.de> <m3shz9in52.fsf@t19.piap.pl>
 <1459248921.2565.15.camel@pengutronix.de> <m3oa9widxk.fsf@t19.piap.pl>
 <CAJ+vNU0iKSXrKmA6jzdw5R5K3TnR3qftVn-8Ou5chHdz5aTpTA@mail.gmail.com>
Message-ID: <m337r1irsc.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tim,

> So perhaps there is something else going on with the tw8689
> device/driver that is causing it to not work with MSI. We have an
> avc8000 miniPCIe with tw8689 here and can test if you send me your
> patches that enable tw8689 with msi.

I think you can use this:
http://git.linuxtv.org/hverkuil/media_tree.git/log/?h=tw686x

> Regardless of MSI working in our tests we still disable it because of
> it breaking legacy irqs and for performance reasons.

So do I. However I'm also using Fedora 23 and this means I have to
recompile the kernel, since they build it with MSI enabled.
I think we should fix it, either by disabling in run time, or making it
work.

Performance-wise, I found it "surprising" that one can't have multiple
MSIs with separate hw vector for each.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
