From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 14:57:13 +0000
Subject: [PATCH v2] ARM: l2c: Fix prefetch settings dt parsing
In-Reply-To: <1425977941-31278-1-git-send-email-fabrice.gasnier@st.com>
References: <1425977941-31278-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20150312145712.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 09:59:01AM +0100, Fabrice GASNIER wrote:
> Allow prefetch settings overriding by device tree, in case
> l2x0_cache_size_of_parse() returns value, prefetch tuning
> properties are silently ignored. E.g. arm,double-linefill* and
> arm,prefetch*.
> This happens for example, when "cache-size" or "cache-sets"
> properties haven't been filled in l2c dt node.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch is okay, but I think the commit message needs to be better :)

"Allow device tree to override the L2C prefetch settings, even when
l2x0_cache_size_of_parse() fails to parse the cache geometry due to (eg)
missing "cache-size" or "cache-sets" properties."

I think with something along those lines, the patch can be put in my
patch system for when I next get around to applying some kernel patches
instead of reading email. :)

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
