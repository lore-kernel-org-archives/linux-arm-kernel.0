From: adobriyan@gmail.com (Alexey Dobriyan)
Date: Fri, 23 Feb 2018 23:41:04 +0300
Subject: [PATCH] net: Allow mac_pton() to work on non-NULL terminated
 strings
In-Reply-To: <20180223201748.14328-1-stefan@the2masters.de>
References: <20180223182006.GA2116@avx2>
 <20180223201748.14328-1-stefan@the2masters.de>
Message-ID: <20180223204104.GA15686@avx2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 09:17:48PM +0100, Stefan Hellermann wrote:
> @@ -8,10 +8,6 @@ bool mac_pton(const char *s, u8 *mac)
>  {
>  	int i;
>  
> -	/* XX:XX:XX:XX:XX:XX */
> -	if (strlen(s) < 3 * ETH_ALEN - 1)
> -		return false;
> -
>  	/* Don't dirty result unless string is valid MAC. */
>  	for (i = 0; i < ETH_ALEN; i++) {
>  		if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))

Short string will bail in the loop, indeed.

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
