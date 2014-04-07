From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 07 Apr 2014 19:14:18 +1000
Subject: [PATCH v7 4/6] pci: Introduce a domain number for pci_host_bridge.
In-Reply-To: <20140407084623.GG17163@e106497-lin.cambridge.arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-5-git-send-email-Liviu.Dudau@arm.com>
 <20140405000007.GD15806@google.com>
 <20140407084623.GG17163@e106497-lin.cambridge.arm.com>
Message-ID: <1396862058.3671.40.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 09:46 +0100, Liviu Dudau wrote:
> 
> *My* strategy is to get rid of pci_domain_nr(). I don't see why we need
> to have arch specific way of providing the number, specially after looking
> at the existing implementations that return a value from a variable that
> is never touched or incremented. My guess is that pci_domain_nr() was
> created to work around the fact that there was no domain_nr maintainance in
> the generic code.

Well, there was no generic host bridge structure. There is one now, it should
go there.

Cheers,
Ben.
 
