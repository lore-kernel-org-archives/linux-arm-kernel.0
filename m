From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Oct 2016 21:02:12 +0200
Subject: [RFC PATCH 1/5] of: introduce the overlay manager
In-Reply-To: <CANLsYkyszsn2TLYhUjHMt2ZnEUmE9eSc71W2KWBL0fWhh3PPBw@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <20161026145756.21689-2-antoine.tenart@free-electrons.com>
 <CANLsYkyszsn2TLYhUjHMt2ZnEUmE9eSc71W2KWBL0fWhh3PPBw@mail.gmail.com>
Message-ID: <20161026210212.09cd85f4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 26 Oct 2016 10:29:59 -0600, Mathieu Poirier wrote:

> > +       overlay = devm_kzalloc(dev, sizeof(*overlay), GFP_KERNEL);  
> 
> Function devm_kzalloc() can sleep but you're holding a spinlock - I'm
> surprised the kernel didn't complain here.  Allocate the memory before
> holding the lock.  If the overly is already loaded simply free it on
> the error path.

Actually, I'm not sure using a spinlock here is appropriate. Using a
mutex would probably be better.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
