From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Jun 2010 12:28:09 +0300
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <20100621135120.24299.98499.stgit@baageli.muru.com>
References: <20100621133749.24299.36154.stgit@baageli.muru.com>
	<20100621135120.24299.98499.stgit@baageli.muru.com>
Message-ID: <20100622092809.GX12255@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100621 16:45]:
> The TLS register is only available on ARM1136 r1p0 and later.
> Set HWCAP_TLS flags if hardware TLS is available.
> 
> Note that we now use 0xffff0ff4 for flagging software TLS to
> __kuser_get_tls, and 0xffff0ff8 for storing the software TLS value.

Forgot my own earlier comment to check only for ARM1136, will update
with this patch.

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: tls-1136.patch
Type: text/x-diff
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100622/94d5fc78/attachment.bin>
