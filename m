From: gsi@denx.de (Gerhard Sittig)
Date: Mon, 3 Mar 2014 20:07:36 +0100
Subject: [PATCH RFC 0/3] clk: CCF clock primitives + custom IO accessors
In-Reply-To: <19206d89-cd0d-4fea-9170-3fd0a8482bf5@VA3EHSMHS045.ehs.local>
References: <1393630495-29689-1-git-send-email-soren.brinkmann@xilinx.com>
 <20140302202940.GQ3327@book.gsilab.sittig.org>
 <19206d89-cd0d-4fea-9170-3fd0a8482bf5@VA3EHSMHS045.ehs.local>
Message-ID: <20140303190736.GU3327@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 09:35 -0800, S?ren Brinkmann wrote:
> 
> It would be nice if we could use the logic provided in the mux, div etc
> primitives independently of how the HW is accessed and what is
> necessary to shift and mask those register values around, right? I
> mean, at then end we want to model a clk-(div|mux) and not a
> clk-(div|mux) which has only a single, memory-mapped control register,
> that does not overlap with other things, ...

Did you lookup the ll_ops discussion in the thread that
originated from
http://article.gmane.org/gmane.linux.ports.arm.kernel/289895 and
did you see the outlined logic in
http://article.gmane.org/gmane.linux.ports.arm.omap/109233 and
http://article.gmane.org/gmane.linux.ports.arm.omap/109381 ?

Support for regmap access instead of mere MMIO was one of the
things you could do with this approach.  You appear to be in the
situation where you need such an extension (or something similar,
but you really should look into the ll_ops thing).


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
