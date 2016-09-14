From: joel@jms.id.au (Joel Stanley)
Date: Wed, 14 Sep 2016 10:29:07 +0930
Subject: [PATCH v3 4/7] palmetto: Request relevant mux functions in
 devicetree
In-Reply-To: <1473800295.8689.295.camel@kernel.crashing.org>
References: <20160830075600.11559-1-andrew@aj.id.au>
 <20160830075600.11559-5-andrew@aj.id.au>
 <CACPK8Xe-dowcwXkO8rDH2reMzGadUMSq5ZtV=23FP4virt+DUQ@mail.gmail.com>
 <1473800295.8689.295.camel@kernel.crashing.org>
Message-ID: <CACPK8XdskPDwnuMVx7xU6rNWn+o-s17FZ3=VQAK1mu4kkfctMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 6:28 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2016-09-13 at 22:11 +0930, Joel Stanley wrote:
>> It's not clear that all systems use these pins in that way. I will
>> not
>> include this one for now.
>
> Well, it has VGA so the VGA hsync, vsync and DDC should be there at
> least...

True. When we enable VGA in our tree these pins will be requested as
part of the VGA driver's device node, so they don't need to be hogged
by the pinctrl node like this.

The ones I'm not clear on are bmc_flack and bmc_int. Andrew, do you
have a recommendation here?

Cheers,

Joel
