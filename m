From: quozl@laptop.org (James Cameron)
Date: Fri, 6 Dec 2013 20:28:22 +1100
Subject: [PATCH v2] serial: rewrite pxa2xx-uart to use 8250_core
In-Reply-To: <1386321003-8960-1-git-send-email-ynvich@gmail.com>
References: <1386286149-2855-1-git-send-email-ynvich@gmail.com>
 <1386321003-8960-1-git-send-email-ynvich@gmail.com>
Message-ID: <20131206092822.GP16425@us.netrek.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 01:09:31PM +0400, Sergei Ianovich wrote:
> pxa2xx-uart was a separate uart platform driver. It was declaring
> the same device names and numbers as 8250 driver. As a result,
> it was impossible to use 8250 driver on PXA SoCs.
> 
> Upon closer examination pxa2xx-uart turned out to be a clone of
> 8250_core driver.
> 
> Workaround for Erratum #19 according to Marvel(R) PXA270M Processor
> Specification Update (April 19, 2010) is dropped. 8250_core reads
> from FIFO immediately after checking DR bit in LSR.

Reviewed-by: James Cameron <quozl@laptop.org>

Thanks.

(for my notes ... V1 has passed 4.5 hours in OLPC's RUNIN test.)

-- 
James Cameron
http://quozl.linux.org.au/
