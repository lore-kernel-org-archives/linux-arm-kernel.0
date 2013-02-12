From: joe@perches.com (Joe Perches)
Date: Mon, 11 Feb 2013 22:17:55 -0800
Subject: [PATCH V4 1/2] get_maintainer: allow keywords to match filenames
In-Reply-To: <1360629574-23989-1-git-send-email-swarren@wwwdotorg.org>
References: <1360629574-23989-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1360649875.5128.18.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-02-11 at 17:39 -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Allow K: entries in MAINTAINERS to match directly against filenames;
> either those extracted from patch +++ or --- lines, or those specified
> on the command-line using the -f option.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -97,12 +97,12 @@ Descriptions of section entries:
>  	   X:	net/ipv6/
>  	   matches all files in and below net excluding net/ipv6/
>  	K: Keyword perl extended regex pattern to match content in a
> -	   patch or file.  For instance:
> +	   patch, or an affected filename.  For instance:

The removal of file isn't correct.

This should read "patch, file or filename".

If the -f pattern is a single file,
get_maintainer reads that file content and then
matches any K: patterns.

When the -f pattern is a directory, it doesn't.

>  	   K: of_get_profile
> -	      matches patches or files that contain "of_get_profile"
> +	      matches patches or filenames that contain "of_get_profile"

here too.

>  	   K: \b(printk|pr_(info|err))\b
> -	      matches patches or files that contain one or more of the words
> -	      printk, pr_info or pr_err
> +	      matches patches or filenames that contain one or more of
> +	      the words printk, pr_info or pr_err

three.

cheers, Joe
