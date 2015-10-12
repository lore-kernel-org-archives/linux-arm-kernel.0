From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 12 Oct 2015 09:29:10 +0200
Subject: [PATCH 3/5] ARM: shmobile: R-Mobile: add missing of_node_put
In-Reply-To: <CAMuHMdUVraBT+s1e-m89KmjbZnEQjBaSz+c93rCOWPMnT5CVPA@mail.gmail.com>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-4-git-send-email-Julia.Lawall@lip6.fr>
 <CAMuHMdUVraBT+s1e-m89KmjbZnEQjBaSz+c93rCOWPMnT5CVPA@mail.gmail.com>
Message-ID: <20151012092910.7580c2b9@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Geert Uytterhoeven,

On Mon, 12 Oct 2015 09:18:52 +0200, Geert Uytterhoeven wrote:

> >                 pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > -               if (!pd)
> > +               if (!pd) {
> > +                       of_node_put(np);
> >                         return -ENOMEM;
> > +               }
> 
> While technically this patch is correct, the system will be dead anyway if it
> ever goes OOM at core_initcall() time.

Then BUG_ON(!pd); ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
