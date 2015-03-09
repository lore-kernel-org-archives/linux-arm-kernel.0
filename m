From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 19:04:41 +0000
Subject: [PATCHv6 1/3] arm: make __get_user() work for 8 byte values
In-Reply-To: <1425646715-20834-2-git-send-email-david.vrabel@citrix.com>
References: <1425646715-20834-1-git-send-email-david.vrabel@citrix.com>
 <1425646715-20834-2-git-send-email-david.vrabel@citrix.com>
Message-ID: <20150309190441.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 12:58:33PM +0000, David Vrabel wrote:
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index ce0786e..d8f535b 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -306,6 +306,7 @@ do {									\
>  	case 1:	__get_user_asm_byte(__gu_val, __gu_addr, err);	break;	\
>  	case 2:	__get_user_asm_half(__gu_val, __gu_addr, err);	break;	\
>  	case 4:	__get_user_asm_word(__gu_val, __gu_addr, err);	break;	\
> +	case 8:	__get_user_asm_dword(__gu_val, __gu_addr, err);	break;	\

Obviously not tested.  __gu_val is an unsigned long - it's 32-bit.  This
will truncate the 64-bit read into 32-bits.

It's going to take some work to sort out something that works, and
right now I don't have time for that (catching up post-op, sorry).

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
