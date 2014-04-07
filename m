From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 7 Apr 2014 11:07:15 +0100
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <1396862058.3671.40.camel@pasglop>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <20140405000007.GD15806@google.com>
 <20140407084623.GG17163@e106497-lin.cambridge.arm.com>
 <1396862058.3671.40.camel@pasglop>
Message-ID: <20140407100715.GI17163@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:14:18AM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2014-04-07 at 09:46 +0100, Liviu Dudau wrote:
> > 
> > *My* strategy is to get rid of pci_domain_nr(). I don't see why we need
> > to have arch specific way of providing the number, specially after looking
> > at the existing implementations that return a value from a variable that
> > is never touched or incremented. My guess is that pci_domain_nr() was
> > created to work around the fact that there was no domain_nr maintainance in
> > the generic code.
> 
> Well, there was no generic host bridge structure. There is one now, it should
> go there.

Exactly! Hence my patch. After it gets accepted I will go through architectures
and remove their version of pci_domain_nr().

Best regards,
Liviu

> 
> Cheers,
> Ben.
>  
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
