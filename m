From: msalter@redhat.com (Mark Salter)
Date: Mon, 29 Aug 2011 12:24:48 -0400
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <CACVXFVNTGsaw2jLosqrTOdnZX399VfE7dWuVYvLcN50_bsa+tQ@mail.gmail.com>
References: <20110829085209.GB26917@n2100.arm.linux.org.uk>
	<Pine.LNX.4.44L0.1108290951250.2525-100000@iolanthe.rowland.org>
	<CACVXFVNTGsaw2jLosqrTOdnZX399VfE7dWuVYvLcN50_bsa+tQ@mail.gmail.com>
Message-ID: <1314635090.2344.53.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-08-29 at 23:55 +0800, Ming Lei wrote:
> If writing to coherent memory can't reach physical memory immediately on
> other ARCHs,  the problem can still happen on these ARCHs. But I am
> not sure if there are these kind of ARCHs except for ARM.

If there is write buffering which prevents outside bus masters from
seeing the data, can we really call it coherent memory?

--Mark
