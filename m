From: peter.p.waskiewicz.jr@intel.com (Waskiewicz Jr, Peter P)
Date: Wed, 23 Jan 2013 22:39:18 -0800
Subject: [PATCH 1/2 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <CAHrpEqSk8bs8552qQ6j_iP9=QNN98NSd1p+TQN=naRr-NUaxkw@mail.gmail.com>
References: <1358914330-3768-1-git-send-email-Frank.Li@freescale.com>
 <1358922071.12374.743.camel@edumazet-glaptop>
 <CAHrpEqTqSfBCpoMZ9S81VoXWgVK1iOR+e2OasARgbTD8m_RRvw@mail.gmail.com>
 <1358948954.12374.758.camel@edumazet-glaptop>
 <CAHrpEqSk8bs8552qQ6j_iP9=QNN98NSd1p+TQN=naRr-NUaxkw@mail.gmail.com>
Message-ID: <20130124063917.GA27481@ppwaskie-mobl2.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 10:26:00AM +0800, Frank Li wrote:
> > A NAPI driver must call netif_receive_skb(), especially if
> > the RX path does a full copy of the frame : Its hot in cpu cache and
> > should be processed at once.
> 
> How about napi_gro_receive? is it correct function? I found many driver use it.

If you want to coalesce your Rx frames to reduce overhead, then yes.  It's
a good performance improvement overall.

-PJ
