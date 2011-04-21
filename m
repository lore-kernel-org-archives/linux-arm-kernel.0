From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Apr 2011 15:47:38 +0300
Subject: [PATCH 1/3] ARM: zImage: no need to get the decompressed size
	from the filesystem
In-Reply-To: <1303272904-31392-2-git-send-email-nicolas.pitre@linaro.org>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<1303272904-31392-2-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110421124737.GB15060@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110420 07:12]:
> In commit d239b1dc093d the hardcoded 4x estimate for the decompressed
> kernel size was replaced by the exact Image file size and passed to
> the linker as a symbol value.  Turns out that this is unneeded as the
> size is already included at the end of the compressed piggy data.
> For those compressed formats that don't include this data, the build
> system already takes care of appending it using size_append in
> scripts/Makefile.lib.  So let's use that instead.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Works fine on the boards I'm using:

Tested-by: Tony Lindgren <tony@atomide.com> 
