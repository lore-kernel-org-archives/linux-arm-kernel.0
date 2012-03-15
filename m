From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 15 Mar 2012 00:25:58 -0600 (MDT)
Subject: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits
 are reprogrammed after a reset
In-Reply-To: <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053657.16278.76132.stgit@dusk>
 <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hola Omar,

On Wed, 14 Mar 2012, Ramirez Luna, Omar wrote:

> If we reached here the reset lines will be asserted, and then the code
> below touches sysc registers on a module under reset.

Do you know of any case where this would be a problem?  Seems like it 
would only affect IP blocks that have both hard reset lines and SYSCONFIG 
registers, and as far as I know, we don't have any of those defined?


- Paul
