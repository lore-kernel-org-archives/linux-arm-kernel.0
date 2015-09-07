From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Sep 2015 12:13:52 +0100
Subject: [PATCH V4 2/2] arm64: Change memcpy in kernel to use the copy
 template file
In-Reply-To: <1440194501-4953-1-git-send-email-fkan@apm.com>
References: <1440194458-4837-1-git-send-email-fkan@apm.com>
 <1440194501-4953-1-git-send-email-fkan@apm.com>
Message-ID: <20150907111351.GB10645@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 03:01:41PM -0700, Feng Kan wrote:
> This converts the memcpy.S to use the copy template file. The copy
> template file was based originally on the memcpy.S. Minor changes
> was made to it to accommodate the copy to/from/in user files.

I think it will be easier to follow if you make this patch the first,
just a simple move of code without any functional change.

> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  arch/arm64/lib/memcpy.S | 179 +++++++-----------------------------------------
>  1 file changed, 26 insertions(+), 153 deletions(-)
> 
> diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
> index 8a9a96d..761acd7 100644
> --- a/arch/arm64/lib/memcpy.S
> +++ b/arch/arm64/lib/memcpy.S
[...]
> +        .macro strh1 label, ptr, regB, val
> +        strh \ptr, [\regB], \val
> +        .endm

There is a problem with the tab/space conversion, either in your editor
or the email server. The above indentation should use tabs (and the
subsequent ones).

-- 
Catalin
