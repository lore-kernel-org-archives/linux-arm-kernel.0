From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 22 Jun 2014 15:15:17 +0400
Subject: [PATCH] xilinx: Fix compiler warning
In-Reply-To: <1403432461-18296-1-git-send-email-manuel.schoelling@gmx.de>
References: <1403432461-18296-1-git-send-email-manuel.schoelling@gmx.de>
Message-ID: <53A6BAC5.80206@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/22/2014 02:21 PM, Manuel Sch?lling wrote:

> The time comparsion functions require arguments of type unsigned long
> instead of (signed) long.

> Signed-off-by: Manuel Sch?lling <manuel.schoelling@gmx.de>

[...]

> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 60c4196..2d069a3 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -351,7 +351,6 @@ static void __init get_fs_names(char *page)
>   				continue;
>   			line++;
>
> -			/* append fsname */
>   			memmove(fsnames, line, strlen(line)+1);
>   			fsnames += strlen(fsnames)+1;
>   		} while (page != NULL);
>

   Seems like unrelated random change.

WBR, Sergei
