From: davidb@codeaurora.org (David Brown)
Date: Tue, 13 Mar 2012 13:47:10 -0700
Subject: [PATCH] arm: Add unwinding support for memset and memzero.
In-Reply-To: <1331574027-28542-1-git-send-email-lauraa@codeaurora.org>
References: <1331574027-28542-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20120313204710.GA1772@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 10:40:27AM -0700, Laura Abbott wrote:
> @@ -41,7 +43,7 @@ ENTRY(memset)
>  	blt	4f
>  
>  #if ! CALGN(1)+0
> -
> +UNWIND(.save {lr})
>  /*
>   * We need an extra register for this loop - save the return address and
>   * use the LR

Did you intend to remove these blank lines?

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
