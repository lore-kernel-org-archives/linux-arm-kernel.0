From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2015 16:32:23 +0000
Subject: [PATCH] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
References: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <20151112163222.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 09:17:35AM -0500, Chris Brandt wrote:
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index b58fd66..195554d 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -26,7 +26,7 @@
>   *	__ctors_start, __ctors_end
>   */
>  extern char _text[], _stext[], _etext[];
> -extern char _data[], _sdata[], _edata[];
> +extern char _data[], _sdata[], _edata[], _edata_loc[];

It's not good practice to put non-generic symbols in generic header files.
_edata_loc is an ARM specific symbol which no other architecture defines.
Please create an ARM private asm/sections.h header, which should include
the asm-generic version, and also declare the additional symbol.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
