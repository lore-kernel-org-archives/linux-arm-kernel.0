From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 10:12:39 -0700
Subject: [PATCH v9 01/15] ARM: Add Krait L2 register accessor functions
In-Reply-To: <9ca51832-6095-c8a5-1347-f57abf99e8f9@codeaurora.org>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
 <1520347148-27852-2-git-send-email-sricharan@codeaurora.org>
 <20180524173926.GC14924@minitux>
 <664089d4-b30d-99bb-2021-12128b2895ba@codeaurora.org>
 <152769571081.144038.4314499217001219157@swboyd.mtv.corp.google.com>
 <9f2e1aa8-21c1-10b0-6193-e6bc16993a0d@codeaurora.org>
 <152775249799.144038.9269415086304305030@swboyd.mtv.corp.google.com>
 <9ca51832-6095-c8a5-1347-f57abf99e8f9@codeaurora.org>
Message-ID: <152787315975.144038.15271372565967690313@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sricharan R (2018-06-01 06:20:37)
> Hi Stephen,
> 
> On 5/31/2018 1:11 PM, Stephen Boyd wrote:
> > 
> > Ok. One general comment is that it would be nice if the bindings for all
> > the nodes that are introduced included 'clocks' properties and also
> > maybe 'clock-names' properties for the clocks that are consumed by each
> > node. Right now, we hide those details from DT and rely on the string
> > names to hook the clk tree up for us. That sort of prevents us from
> > moving away from string easily, so I would just throw the clocks into
> > the binding right now and always have them there just in case we want to
> > use the binding to figure out the hierarchy in the future.
> > 
> 
>  ok, understand that mostly. So will try to revamp those patches with
>  the 'clocks' property in the binding added, reading them in the driver
>  from DT.

Yeah. You don't even have to actually use the clocks property right now
from the drivers. Just add the properties in the binding.
