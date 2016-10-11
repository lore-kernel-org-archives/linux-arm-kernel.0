From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 11 Oct 2016 12:18:20 +0300
Subject: [PATCH v2] sdhci-esdhc-imx: Correct two register accesses
In-Reply-To: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
References: <1476124792-18441-1-git-send-email-aaron.brice@datasoft.com>
Message-ID: <4e944cda-05c6-0515-c98d-e90600f63541@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/16 21:39, Aaron Brice wrote:
>  - The DMA error interrupt bit is in a different position as
>    compared to the sdhci standard.  This is accounted for in
>    many cases, but not handled in the case of clearing the
>    INT_STATUS register by writing a 1 to that location.
>  - The HOST_CONTROL register is very different as compared to
>    the sdhci standard.  This is accounted for in the write
>    case, but not when read back out (which it is in the sdhci
>    code).
> 
> Signed-off-by: Dave Russell <david.russell@datasoft.com>
> Signed-off-by: Aaron Brice <aaron.brice@datasoft.com>
> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
