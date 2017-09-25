From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Mon, 25 Sep 2017 09:03:45 +0200
Subject: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170920224621.16236-2-tony@atomide.com>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-2-tony@atomide.com>
Message-ID: <20170925070345.2uraikhswru77rm4@squirrel.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 03:46:12PM -0700, Tony Lindgren wrote:
> TI sysc interconnect target module hardware is independent of the
> interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> and TI L4 interconnect (Sonics s3220).

This is because the interface between interconnect and module is
standardized (Open Core Protocol), so it doesn't really matter which
interconnect technology is used.

Also, afaik sysc mostly just concerns the interaction between module and
PRCM.  The only role the interconnect plays here is that it participates
in the OCP Disconnect Protocol to allow the module to safely disconnect
itself when it or the interconnect enters idle state.

Matthijs
