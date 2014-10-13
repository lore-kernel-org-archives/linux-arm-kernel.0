From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Oct 2014 13:02:54 +0200
Subject: [PATCH] vfio/pci: make MSI handling optional
In-Reply-To: <1413190208.4202.34.camel@ul30vt.home>
References: <6188781.C8VgeYvZpD@wuerfel> <1413190208.4202.34.camel@ul30vt.home>
Message-ID: <2147756.6NWYQ577Sd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 October 2014 02:50:08 Alex Williamson wrote:
> 
> Why wouldn't we handle this with stubs for `get_cached_msi_msg' and
> `write_msi_msg'?  We're really not talking about much code that might
> get removed by the compiler with this static branch and and it seems
> like a rather non-standard mechanism.  The count of MSI/X IRQs
> advertised to the user should be zero without CONFIG_MSI and later range
> checks would prevent calls to
> these functions for invalid indexes, so it's a bit of a random test in
> the code flow.  Thanks,
> 

That's fine with me too.

	Arnd
